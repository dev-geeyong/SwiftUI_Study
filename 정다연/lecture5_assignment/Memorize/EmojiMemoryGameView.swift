//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/03.
//

import SwiftUI

/*
 - 테마 4개 추가 및 이름 표시
 - 점수 계산 및 표시
 - 새 게임 버튼 추가
 - 카드 섞기 버튼 추가
 */

struct EmojiMemoryGameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  
  var body: some View {
    VStack {
      Text("Memorize Game")
        .font(.title)
      
      Text("테마: \(viewModel.theme.name)")
        .font(.headline)
        .foregroundColor(viewModel.theme.color)
      
      ScrollView {
        cards
          .animation(.default, value: viewModel.cards)
      }
      
      Spacer()
      
      HStack {
        Button(
          action: { viewModel.reset() },
          label: {
            VStack {
              Image(systemName: "plus.circle.fill").font(.largeTitle)
              Text("New Game")
            }
          })
        .padding()
//        .background(Color.purple)
        
        Button(action: { viewModel.shuffle() }) {
            VStack {
              Image(systemName: "shuffle.circle.fill").font(.largeTitle)
              Text("Shuffle").font(.caption)
            }
          }
        .padding()
//        .background(Color.red)
        
      }
      .foregroundColor(viewModel.theme.color)
  
      Text("점수: \(viewModel.score)")
          .font(.title)
          .foregroundColor(Color.black)
      
    }
    .padding()
  }
  
  var cards: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
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
      Group {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2)
        Text(card.content)
          .font(.system(size: 200))
          .minimumScaleFactor(0.01)
          .aspectRatio(contentMode: .fit)
      }
      .opacity(card.isFaceUp ? 1:0)
      base.fill()
        .opacity(card.isFaceUp ? 0:1)
    }
    .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
  }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
  }
}
