//
//  ContentView.swift
//  Memorize
//
//  Created by 우승현 on 10/31/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView { cards }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    // 카드 수 조절 버튼
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjustor(by: -1, symbol: "rectangle.stack.badge.minus.fill")
            Spacer()
            cardCountAdjustor(by: 1, symbol: "rectangle.stack.badge.plus.fill")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjustor(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        // 범위 넘어가면 삭제나 추가 안되도록 함
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

// 카드 뷰
struct CardView: View {
    let content: String
    @State var isFaceUp = true
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
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
