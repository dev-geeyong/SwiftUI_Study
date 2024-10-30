//
import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
//    @State private var cardFaceUps = Array(repeating: false, count: (theme1 + theme1).count)
//    @State private var emojis = (theme1 + theme1).shuffled()
    @State var themeColor = Color.orange  // 테마 색상 추가
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView { cards }
            Button("Shuffle") {
                viewModel.shuffle()
            }
//            Spacer()
//            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0) {
            ForEach(0..<viewModel.cards.count, id: \.self) { index in
                CardView(viewModel.cards[index])
                .aspectRatio(2/3, contentMode: .fit)
                .padding(4)
            }
        }
        .foregroundColor(themeColor)
    }
    
//    var themeButtons: some View {
//        HStack {
//            themeButton(name: "Halloween",
//                        symbol: "party.popper.fill",
//                        theme: theme1,
//                        color: .orange)
//            themeButton(name: "Sports",
//                        symbol: "tennisball.fill",
//                        theme: theme2,
//                        color: .blue)
//            themeButton(name: "Animals",
//                        symbol: "pawprint.fill",
//                        theme: theme3,
//                        color: .red)
//        }
//        .imageScale(.large)
    }
    
//    func themeButton(name: String, symbol: String, theme: [String], color: Color) -> some View {
//        Button(action: {
//            emojis = (theme + theme).shuffled()  // 테마의 카드 쌍을 섞음
//            cardFaceUps = Array(repeating: false, count: emojis.count)
//            themeColor = color
//        }, label: {
//            VStack {
//                Image(systemName: symbol)
//                    .font(.title)
//                Text(name)
//                    .font(.caption)
//            }
//        })
//    }


struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
//        .onTapGesture {
//            isFaceUp.toggle()
//        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
