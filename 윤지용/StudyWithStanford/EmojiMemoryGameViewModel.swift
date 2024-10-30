//
//  EmojiMemoryGame.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/28/24.
// ViewModel

import SwiftUI


// MemoryGame - init(numberOfPairOfCards: Int, createCardContent: (Int) -> CardContent) {


class EmojiMemoryGameViewModel: ObservableObject {
    
    private static let theme1 = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    private static let theme2 = ["⚽","🏏","🏓","🥏","🎾","🏄"]
    private static let theme3 = ["🦈", "🦑", "🐙","🦉","🐧","🦖","🦧"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        
        MemoryGame<String>(numberOfPairOfCards: 16) { pairIndex in
            if theme1.indices.contains(pairIndex) {
                theme1[pairIndex]
            } else {
                "🏄"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    /*
     
     인스턴스 멤버 초기화 오류:
     model = createMemoryGame()에서 에러가 발생합니다
     인스턴스 프로퍼티는 다른 인스턴스 메서드를 사용해 초기화할 수 없습니다
     이유: 인스턴스가 완전히 초기화되기 전에 인스턴스 메서드를 호출할 수 없기 때문입니다
     

    class EmojiMemoryGame {
        private let theme1 = ["👻", "🎃", "🦇"]
        
        private func createMemoryGame() -> MemoryGame<String> {
            MemoryGame<String>(numberOfPairOfCards: 4) { pairIndex in
                theme1[pairIndex]  // self.theme1 접근
            }
        }
        
        // ❌ 오류 발생
        private var model = createMemoryGame()
    }
     class EmojiMemoryGame {
         // 1️⃣ 먼저 모든 프로퍼티가 초기화되어야 함
         private let theme1 = ["👻", "🎃", "🦇"]
         private var model: MemoryGame<String>
         
         // 2️⃣ 그 다음에야 메서드 사용 가능
         private func createMemoryGame() -> MemoryGame<String> {
             // self 사용 가능
             return MemoryGame(numberOfPairOfCards: 4) { pairIndex in
                 self.theme1[pairIndex]
             }
         }
     }
         class EmojiMemoryGame {
             private let theme1 = ["👻", "🎃", "🦇","🧛","⚰️","🧙"]
     
             // 방법 1: 초기화 시점에 직접 생성
             private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairOfCards: 4) { pairIndex in
                 // 여기서 theme1에 접근 불가! ❌
                 // self.theme1[pairIndex] // 에러!
             }
     
             // 방법 2: 생성자 사용
             init() {
                 model = MemoryGame<String>(numberOfPairOfCards: 4) { pairIndex in
                     self.theme1[pairIndex]
                 }
             }
         }
     
    */
    
    
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

