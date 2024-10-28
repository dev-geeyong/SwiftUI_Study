//
import SwiftUI

let theme1 = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
let theme2 = ["⚽","🏏","🏓","🥏","🎾","🏄"]
let theme3 = ["🦈", "🦑", "🐙","🦉","🐧","🦖","🦧"]

struct ContentView: View {
    @State private var cardFaceUps = Array(repeating: false, count: (theme1 + theme1).count)
    @State private var emojis = (theme1 + theme1).shuffled()
    @State var themeColor = Color.orange  // 테마 색상 추가
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView { cards }
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index],
                         isFaceUp: $cardFaceUps[index])
                .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(themeColor)
    }
    
    var themeButtons: some View {
        HStack {
            themeButton(name: "Halloween",
                        symbol: "party.popper.fill",
                        theme: theme1,
                        color: .orange)
            themeButton(name: "Sports",
                        symbol: "tennisball.fill",
                        theme: theme2,
                        color: .blue)
            themeButton(name: "Animals",
                        symbol: "pawprint.fill",
                        theme: theme3,
                        color: .red)
        }
        .imageScale(.large)
    }
    
    func themeButton(name: String, symbol: String, theme: [String], color: Color) -> some View {
        Button(action: {
            emojis = (theme + theme).shuffled()  // 테마의 카드 쌍을 섞음
            cardFaceUps = Array(repeating: false, count: emojis.count)
            themeColor = color
        }, label: {
            VStack {
                Image(systemName: symbol)
                    .font(.title)
                Text(name)
                    .font(.caption)
            }
        })
    }
}

struct CardView: View {
    let content: String
    @Binding var isFaceUp: Bool
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
