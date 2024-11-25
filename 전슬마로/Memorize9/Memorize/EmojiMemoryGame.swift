//
//  EmojiMemoryGame.swift
//  Memorize
//
//

import SwiftUI
// 뷰모델
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    
    // 새로운 MemoryGame 인스턴스를 생성
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex){
                emojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
    
    // 모델 변경 시 SwiftUI 뷰가 자동으로 다시 렌더링
    @Published private var model = createMemoryGame()
    
    // 모델에 의존 되는 요소
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var color: Color {
        .orange
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
