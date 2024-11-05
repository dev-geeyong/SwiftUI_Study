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
                    .aspectRatio(2/3, contentMode: .fit)//카드의 가로세로 비율
//                // 1:1 비율 (정사각형)
//                .aspectRatio(1/1, contentMode: .fit)
//
//                // 2:1 비율 (가로가 세로의 2배)
//                .aspectRatio(2/1, contentMode: .fit)
//
//                // 1:2 비율 (세로가 가로의 2배)
//                .aspectRatio(1/2, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
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
        // disables button use with conditions
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

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
