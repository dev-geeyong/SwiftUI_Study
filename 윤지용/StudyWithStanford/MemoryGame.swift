//
//  MemoryGame.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/28/24.
// Model

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable { //CardContent 타입이 반드시 Equatable 프로토콜을 준수해야 한다는 조건을 붙인 것입니다
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
        let index = index(of: card)
        cards[index].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // FIXME: bug
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


