//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/03.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
