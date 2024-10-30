//
//  StudyWithStanfordApp.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/22/24.
//

import SwiftUI

@main
struct StudyWithStanfordApp: App {
    @StateObject var game = EmojiMemoryGameViewModel()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
