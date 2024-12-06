//
//  Widget_Memorize09App.swift
//  Widget+Memorize09
//
//  Created by 정다연 on 12/6/24.
//

import SwiftUI

@main
struct Memorize09App: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
