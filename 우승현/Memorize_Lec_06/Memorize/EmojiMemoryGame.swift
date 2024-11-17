//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 우승현 on 11/17/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    var theme = themes.randomElement()!
    
    init() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.noOfPairs!) { pairIndex in
            if emojis.indices.contains(pairIndex){
                emojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> { model.cards }
    var score: Int { model.score }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
