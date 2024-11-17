//
//  MemoryGame.swift
//  Memorize
//
//  Created by 우승현 on 11/17/24.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index  in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            print("Card chosen: \(chosenIndex)")
            // 고른 카드가 뒷면이고, 매치되지 않은 경우
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    cards[chosenIndex].hasBeenFlipped += 1
                    cards[potentialMatchIndex].hasBeenFlipped += 1
                    print("\(chosenIndex)과 \(potentialMatchIndex) 카드를 비교합니다.")
                    // Match Case
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        print("\(chosenIndex)과 \(potentialMatchIndex) 카드가 같습니다.")
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 1
                    } else if cards[chosenIndex].hasBeenFlipped > 1 || cards[potentialMatchIndex].hasBeenFlipped > 1 {
                        score -= 1
                    }
                } else {
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        var hasBeenFlipped: Int = 0
        
        var debugDescription: String {
            "\(id): \(content)"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
