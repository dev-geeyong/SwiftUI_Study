//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 우승현 on 11/17/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
            
            Text(viewModel.theme.name)
                .font(.headline)
                .foregroundColor(viewModel.theme.color)
            
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards )
            }
            HStack {
                Button(action: {
                    viewModel.newGame()
                }, label: {
                    VStack(spacing: 5) {
                        Image(systemName: "plus.circle.fill").font(.largeTitle)
                        Text("New Game")
                    }
                })
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
                    .font(.title)
                    .foregroundColor(Color.black)
                
                Spacer()
                
                Button(action: {
                    viewModel.shuffle()
                }, label: {
                    VStack(spacing: 5) {
                        Image(systemName: "shuffle.circle.fill").font(.largeTitle)
                        Text("Shuffle")
                    }
                })
            }
            .foregroundColor(viewModel.theme.color)
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.theme.color)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Text(card.content)
                .font(.system(size: Constants.FontSize.largest))
                .minimumScaleFactor(Constants.FontSize.scaleFactor)
                .multilineTextAlignment(.center)
                .aspectRatio(1, contentMode: .fit)
                .padding(Constants.Pie.inset)
                .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                .animation(.spin(duration: 1), value: card.isMatched)
                .opacity(card.isFaceUp ? 1 : 0)
        }
        .padding(Constants.inset)
        .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

