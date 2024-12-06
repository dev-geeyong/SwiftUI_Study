//
//  MemoryGame.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/28/24.
// Model

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable { //CardContent 타입이 반드시 Equatable 프로토콜을 준수해야 한다는 조건을 붙인 것입니다
    private(set) var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFacUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }
        }
        
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
//            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                } else{
//                    cards[index].isFaceUp = false
//                }
//            }
        }
    }
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched { //뒤집어있고 매치된게 아니라면
                if let potentialMatchIndex = indexOfTheOneAndOnlyFacUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    
                } else {
                    indexOfTheOneAndOnlyFacUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for index in 0..<max(2,numberOfPairOfCards) {
            let content = createCardContent(index)
            cards.append(Card(content: content, id: "\(index + 1)a"))
            cards.append(Card(content: content, id: "\(index + 1)b"))
        }
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content)"
        }
        
        
        
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: String
    }
}
/*
 ⚠️ mutating 없이 cards를 수정하려 하면 에러 발생
 struct는 값 타입이므로 기본적으로 불변(immutable)입니다
 struct의 메서드에서 프로퍼티를 변경하려면 mutating 키워드가 필요합니다
 mutating은 "이 메서드는 구조체의 상태를 변경할 수 있다"고 컴파일러에게 알려줍니다
 // 클래스 (참조 타입) - mutating 불필요
 */


//https://bbiguduk.gitbook.io/swift


