//
//  EmojiMemoryGame.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/28/24.
//  ViewModel (발행자)

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject { 
    // ViewModel이 관찰 가능한 객체임을 선언 View는 @ObservedObject를 통해 이 변경사항을 구독
    
    private static let theme1 = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        
        MemoryGame<String>(numberOfPairOfCards: 16) { pairIndex in
            if theme1.indices.contains(pairIndex) {
                theme1[pairIndex]
            } else {
                "🏄"
            }
        }
    }
    // @Published로 표시된 프로퍼티의 변경사항을 자동으로 발행
    @Published private var model = createMemoryGame()
    // 1. @Published로 표시된 프로퍼티가 변경되면
    

    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    func shuffle() {
        model.shuffle()  // 2. 이 변경이 발생할 때
               // 3. ObservableObject가 자동으로 알림을 보냄
               // 4. 이 알림을 구독하고 있는 View들이 업데이트됨
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

