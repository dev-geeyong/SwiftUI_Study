//
import SwiftUI

struct EmojiMemoryGameView: View {
    
    /*
     @ObservedObject는 ObservableObject(ViewModel)의 변경사항을 관찰
     ViewModel의 @Published 프로퍼티 변경 시 자동으로 View 업데이트
     MVVM 패턴에서 View와 ViewModel을 연결하는 역할
     */
    @ObservedObject var viewModel: EmojiMemoryGameViewModel // ViewModel의 변경사항을 관찰하고 UI를 자동으로 업데이트
    
    @State var themeColor = Color.orange
    
    var body: some View {
        // viewModel의 변경사항이 감지되면 View가 자동으로 새로 그려짐
        
        VStack {
            HStack{
                Text(viewModel.cards.first?.title ?? "").font(.largeTitle)
                Spacer()
                Text("Score: \(viewModel.score)").font(.largeTitle)
            }
            ScrollView { cards
                .animation(.default, value: viewModel.cards)
            }
            Button("NewGame") {
                viewModel.newGame()
            }
        }
        .padding()
    }
    
    var cards: some View {
       LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0) {
           ForEach(viewModel.cards) { card in
               CardView(card)
                   .aspectRatio(2/3, contentMode: .fit)
                   .padding(4)
                   .onTapGesture {
                       viewModel.choose(card)
                   }
           }
       }
       .foregroundStyle(
           LinearGradient(
               colors: [
                   Color(uiColor: viewModel.cards.first?.color ?? .orange),
                   Color(uiColor: viewModel.cards.first?.color ?? .orange).opacity(0.5)
               ],
               startPoint: .topLeading,
               endPoint: .bottomTrailing
           )
       )
    }
    
}



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
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
