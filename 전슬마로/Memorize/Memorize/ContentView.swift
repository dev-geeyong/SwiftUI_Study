//
//  ContentView.swift
//  Memorize
//

import SwiftUI

let theme1: Array<String> = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
let theme2: Array<String> = ["⚽","🏏","🏓","🥏","🎾","🏄"]
let theme3: Array<String> = ["🦈", "🦑", "🐙","🦉","🐧","🦖","🦧"]

// swiftUI 에서는 슈퍼클래스라는 개념이 었다 함수형 프로그래밍에 기반을 두고 있기 때문이다
// UI구성의 내용이 담긴 ContentView는 결국 View 구조체이며, 이러한 구조체 안에는 여러 가지 변수, 메서드를 담아낼 수 있다.
// ContentView의 body는 변수로 선언이 되어있지만, 메모리에 저장되지 않는다
// body에 접근할 때마다 body 뒤에 이어진 { ... } 블록의 해당 함수 내용을 수행하고 반환되는 결과를 받아 오는 것이다.
// 이는 swift의 큰 특징 중 하나인 함수형 프로그래밍에 의한 표현
struct ContentView: View {
    @State var emojis = theme1
    @State var themeColor = Color.orange
    
    //some View ? "View처럼 행동하는 무언가" 해당 부분을 레고에 비유
    // 레고로 집을 만든다고 하였을 때, 작은 단위의 레고를 모아 의자, 소파, 테이블과 같은 작은 단위의 레고를 만들고, 그것들이 모여 거실, 방, 지붕과 같은 큰 단위로 결합
    // SwiftUI 또한 작은 단위의 View가 결합되어 하나의 View를 구성하게끔 동작
    // 즉 수많은 종류의 View 중에 어떤 형태의 View가 반환될지 모르기에 some View라는 키워드로 치환
    var body: some View {
        Text("Memorize!").font(.largeTitle)
        VStack {
            ScrollView {
                cards
            }
            themeSetters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160
                                              ))]) { // 최소 크기를 지정하고 가능한 많은 항목을 한 행에 배치
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit) // 카드의 비율을 조정해서 자동으로 조정. fit 옵션을 사용해서 가로 세로중 더 작은 크기를 기준으로
            }
        }
        .foregroundColor(themeColor)
    }
    
    var themeSetters: some View {
        HStack(alignment: .lastTextBaseline) { // 텍스트 기준선을 가장 마지막에 위치한 텍스트 View의 기준선에 맞춥
            themeSet(of: "Halloween", symbol: "party.popper.fill")
            themeSet(of: "Sports", symbol: "tennis.racket")
            themeSet(of: "Animals", symbol: "dog.fill")
        }
        .imageScale(.large)
    }
    
    
    func themeSet(of theme: String, symbol: String) -> some View {
        Button(action: { // 버튼을 생성하고, 버튼을 누르면 실행
            switch theme {
            case "Halloween":
                emojis = (theme1 + theme1).shuffled()
                themeColor = Color.orange
            case "Sports":
                emojis = (theme2 + theme2).shuffled()
                themeColor = Color.red
            case "Animals":
                emojis = (theme3 + theme3).shuffled()
                themeColor = Color.blue
            default: emojis = (theme1 + theme1).shuffled()
            }
        }, label: {
            VStack(spacing: 5) {
                Image(systemName: symbol).font(.title)
                Text(theme).font(.caption)
            }
        })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack { // content { ... } 인자 내에 단순히 View를 나열하기만 하면 스크린 - 사용자 방향 순서로 view를 결합하는 기능을 수행
            Group { // 여러뷰를 하나의 단위로 묶을수 있음
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
