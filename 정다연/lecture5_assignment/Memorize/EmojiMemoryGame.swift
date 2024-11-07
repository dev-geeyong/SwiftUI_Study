//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/03.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  var themes: [Themes] = [.person, .activity, .place, .sign]

  @Published private var model: MemoryGame<String>
  var theme: Themes
  
  init() {
    let theme = themes.randomElement() ?? .person
    self.theme = theme
    model = EmojiMemoryGame.createMemoryGame(theme: theme)
  }
  
  private static func createMemoryGame(theme: Themes) -> MemoryGame<String> {
    let emojis = theme.emojis.shuffled()
    return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
      if emojis.indices.contains(pairIndex) {
        return emojis[pairIndex]
      } else {
        return "⁉️"
      }
    }
  }
  
  var cards: Array<MemoryGame<String>.Card> {
    return model.cards
  }
  var score: Int { model.score }
  
  // MARK: - Intents
  
  func shuffle() {
    model.shuffle()
  }
  
  func choose(_ card: MemoryGame<String>.Card) {
    model.choose(card)
  }
  
  func reset() {
    theme = themes.randomElement() ?? .person
    model = EmojiMemoryGame.createMemoryGame(theme: theme)
  }
}
