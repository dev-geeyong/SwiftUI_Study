//
//  MemorizeGame.swift
//  Memorize
//
//

import Foundation

// 카드가 서로 같거나 다른지 비교할 수 있게 Equatable 준수
struct MemoryGame<CardContent> where CardContent: Equatable {
    /// 게임에 사용되는 카드 배열
    private(set) var cards: Array<Card>
    /// 현재 게임의 점수
    private(set) var score = 0
    
    
    /// MemoryGame 초기화
    /// - Parameters:
    ///   - numberOfPairsOfCards: 카드 쌍의 개수
    ///   - cardContentFactory: 인덱스로 카드 반환
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            // 같은것이 2장 있어야 하니 2장 생성
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        // 현재 뒤집힌 카드 인덱스
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        // 카드 뒤집기
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    // 카드를 선택했을 때 호출
    mutating func choose(_ card: Card) {
        // 선택된 카드의 인덱스를 찾음
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    // 두 카드가 매치되었는지 확인
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        // 매치 처리
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                    } else {
                        // 매치되지 않으면 점수 차감
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    // 카드 섞기
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var isFaceUp = false {
            didSet {
                // 카드가 뒤집힐 때 시간 측정
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                // 이전에 뒤집힌 기록
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        let content: CardContent
        
        var id: String
        var description: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "")"
        }
        
        // MARK: - Bonus Time
        
        // 시간계산
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        // 현재까지 획득한 점수
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // 남아있는 보너스 시간 백분율
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // 카드 뒤집힌 시간
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeLimit: TimeInterval = 6
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
    }
}

extension Array {
    /// 배열에 요소가 하나만 있는 경우 해당 요소를 반환
    var only: Element? {
        count == 1 ? first : nil
    }
}
