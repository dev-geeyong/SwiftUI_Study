//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/03.
//

import SwiftUI

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

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
      ZStack {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
      }
    }
}

