//
//  Cardify.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 11/11/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.strokeBorder(lineWidth: Constants.lineWidth)
                    .background(base.fill(.white))
                    .overlay(content)
                    .opacity(isFaceUp ? 1:0)
                base.fill()
                    .opacity(isFaceUp ? 0:1)
            }
        }
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

/*
 이러한 분리를 통해:
 코드의 재사용성 향상
 유지보수 용이성 증가
 책임의 명확한 분리
 확장성 개선
 SwiftUI의 디자인 패턴 준수
 */
