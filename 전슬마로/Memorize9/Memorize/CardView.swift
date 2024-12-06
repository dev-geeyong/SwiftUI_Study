//
//  CardView.swift
//  Memorize
//
//

import SwiftUI

// Card 타입을 MemoryGame<Card>의 카드로 간단히 재정의
typealias Card = CardView.Card

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    /// 현재 표시할 카드
    let card: Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View { // 빈번한 업데이트 일어나서 무거운 작업은 피하자
        TimelineView(.animation) { timeline in // 애니메이션 프레인마다 호출되어서 그려진다
            // 카드가 앞면이거나 매치되지 않은 상태일 때:
            if card.isFaceUp || !card.isMatched {
                // 카드의 남은 시간에 따른 angle 정의
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    // 카드 내용물을 오버레이로 추가
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    // 카드 모양 설정
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                // 카드가 매치된 경우 공간을 유지하기 위해
                Color.clear
            }
        }
    }
    
    // 카드 텍스트 콘텐트
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            // 텍스트 크기를 최소 크기까지 축소할 수 있도록
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            // 텍스트의 가로세로 비율을 고정
            .aspectRatio(1, contentMode: .fit)
            // 매치된 경우 텍스트를 360도 회전시키는 애니메이션
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            // 매치된 상태를 감지하여 회전 애니메이션 실행
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200 // 텍스트 최대크기
            static let smallest: CGFloat = 10 // 텍스트 최소크기
            static let scaleFactor = smallest / largest // 축소비율
        }
        struct Pie {
            static let opacity: CGFloat = 0.4 // 투명도
            static let inset: CGFloat = 5 // 파이 텍스트 인셋
        }
    }
}

extension Animation {
    // 회전 애니메이션 정의
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
    VStack {
        HStack {
            CardView(Card(isFaceUp: true, content: "하나", id: "test1"))
            CardView(Card(content: "둘", id: "test1"))
        }
        HStack {
            CardView(Card(isFaceUp: true, content: "하나둘셋넷다섯여섯일곱", id: "test1"))
            CardView(Card(content: "호호", id: "test1"))
        }
    }
    .padding()
    .foregroundColor(.blue)
}
