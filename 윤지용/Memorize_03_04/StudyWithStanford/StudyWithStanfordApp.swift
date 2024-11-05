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

/*
 @StateObject의 특징:

 ObservableObject의 인스턴스를 저장하고 관리
 View가 재생성되어도 데이터가 유지됨
 앱의 생명주기 동안 단 한 번만 초기화됨
 주로 데이터의 원천을 만들 때 사용
 
 */
