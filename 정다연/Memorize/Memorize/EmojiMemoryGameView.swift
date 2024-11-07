//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/03.
//

import SwiftUI

/*
 1. 애니메이션 처리
 - Equatable
 - Hashable
 - Identifiable
 */

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
  
    var body: some View {
        VStack {
            ScrollView {
                cards
                .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
      AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
                  CardView(card)
                      .padding(4)
                      .onTapGesture {
                          viewModel.choose(card)
                      }
              }
              .foregroundColor(Color.orange)
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
          
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
//            .opacity(card.isFaceUp ? 1:0)
            base.fill()
                .opacity(card.isFaceUp || card.isMatched ? 0 : 1)
        }
    }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
      ZStack {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
      }
    }
}

