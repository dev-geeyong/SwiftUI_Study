//
//  Cardify.swift
//  Memorize
//
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180 // 0도는 앞면, 180도는 뒷면
    }
    
    var isFaceUp: Bool {
        rotation < 90 // 회전 각도가 90도 미만이면 앞면
    }
    
    // 카드를 회전시키는 각도
    var rotation: Double
    
    var animatableData: Double {
        get { return rotation } // 현재 회전 각
        set { rotation = newValue } // 새로운 회전 각
    }
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            // 뒷면
            base.fill(.orange)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
