//
//  EmojiMemoryGame.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/28/24.
// ViewModel

import SwiftUI


// MemoryGame - init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {


class EmojiMemoryGame {
    
    static let theme1 = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    static let theme2 = ["⚽","🏏","🏓","🥏","🎾","🏄"]
    static let theme3 = ["🦈", "🦑", "🐙","🦉","🐧","🦖","🦧"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairOfCards: 4) { pairIndex in
            theme1[pairIndex]
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //func makeCardContent(index: Int) -> String {
    //    return "👻"
    //}
    //    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairOfCards: 4, createCardContent: <#T##(Int) -> String#>)
    
    //    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairOfCards: 4, createCardContent: makeCardContent)
    
    //    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairOfCards: 4, createCardContent:{ (index: Int) -> String in
    //        return "👻"
    //    })
    //    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairOfCards: 4, createCardContent:{ index in "👻" })
    
    //    private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairOfCards: 4 ) {index in "👻"}
}

