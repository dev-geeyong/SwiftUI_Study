//
//  MemoryGame.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/28/24.
// Model

import Foundation


struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }

    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for index in 0..<max(2,numberOfPairOfCards) {
            let content = createCardContent(index)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
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


