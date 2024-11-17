//
//  Cardify.swift
//  Memorize
//
//  Created by CS193p Instructor on 4/26/23.
//

import SwiftUI

struct Cardify: ViewModifier {
  let id: String
  let isFaceUp: Bool
  let isMatched: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
      base.strokeBorder(lineWidth: Constants.lineWidth)
        .background(base.fill(.white))
        .overlay(content)
      
      // FIXME: isMatched == true인 카드가 보임.
      
      base.fill()
        .opacity(isFaceUp || isMatched ? 0 : 1)
    }
  }
  
  private struct Constants {
    static let cornerRadius: CGFloat = 16
    static let lineWidth: CGFloat = 4
  }
}

extension View {
  func cardify(isFaceUp: Bool, isMatched: Bool, id: String) -> some View {
    modifier(Cardify(id: id, isFaceUp: isFaceUp, isMatched: isMatched))
  }
}
