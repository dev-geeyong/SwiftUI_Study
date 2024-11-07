import SwiftUI
// 해당 어노테이션은 UIKit으로 생성한 프로젝트에서 AppDelegate 파일에 있던 어노테이션으로 앱의 진입지점(entry point)를 나타낸다.
// 즉 swiftUI의 진입지점(entry point)은 App.swift 파일이며 해당 App 객체의 생성으로 앱의 실행으로 이어진다
@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
