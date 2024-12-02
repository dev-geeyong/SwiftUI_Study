//
//  FlyingNumber.swift
//  Memorize
//
//

import SwiftUI
// 숫자 값을 받아 애니메이션 효과와 함께 화면에 표시하는 역할
struct FlyingNumber: View {
    // 화면에 표시할 숫자 값
    let number: Int
    // 숫자가 화면에서 이동하는 위치를 제어하는 상태 변수
    @State private var offset: CGFloat = 0
    
    var body: some View {
        // 숫자가 0이 아닐 때만 표시
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                // 숫자가 음수이면 빨간색, 양수이면 초록색
                .foregroundColor(number < 0 ? .red : .green)
                // 텍스트에 그림자 효과 추가
                .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                // y축에 offset 적용하여 텍스트의 위치를 위/아래로 이동
                .offset(x: 0, y: offset)
                // offset이 0이 아니면 투명하게 처리하고, 0일 때만 보이도록 설정
                .opacity(offset != 0 ? 0 : 1)
                // 화면에 나타날 때 애니메이션을 통해 위치를 이동
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5)) {
                        // 숫자가 음수이면 200만큼 아래로, 양수이면 200만큼 위로 이동
                        offset = number < 0 ? 200 : -200
                    }
                }
                // 화면에서 사라질 때 offset을 원래 상태로 되돌림
                .onDisappear {
                    offset = 0
                }
        }
    }
}

#Preview {
    // 숫자 5로 미리보기
    FlyingNumber(number: 5)
}
