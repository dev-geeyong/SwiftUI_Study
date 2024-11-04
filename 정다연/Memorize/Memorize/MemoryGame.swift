//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/03.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
          cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
          cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
  
  mutating func choose(_ card: Card) {
    let chosenIndex = index(of: card)
    cards[chosenIndex].isFaceUp.toggle()
  }
    
  func index(of card: Card) -> Int {
    for index in cards.indices {
      if cards[index].id == card.id {
        return index
      }
    }
    return 0  // FIXME: bogus!
  }
  
    mutating func shuffle() {
        cards.shuffle()
//      print(cards)
    }
    
  struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
    // Equatable을 준수하도록 해야 같음을 비교할 수 있음
    // CardContent 도 Equatable을 준수해야 함
//    static func == (lhs: Card, rhs: Card) -> Bool {
//      return lhs.isFaceUp == rhs.isFaceUp &&
//      lhs.isMatched == rhs.isMatched &&
//      lhs.content == rhs.content
//    }
    // 모든 항목이 Equatable하면 == 을 정의하지 않아도 됨
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    
    // Identifiable - 카드 자체를 고유한 것으로 식별할 수 있어야 함
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "unmatched")"
        }
    }
}
