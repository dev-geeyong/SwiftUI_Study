//
//  Pie.swift
//  Memorize
//
//

import SwiftUI
// For custom drawing
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    // 시계 방향으로 그려질지 여부
    let clockwise = true
    
    func path(in rect: CGRect) -> Path {
        // 시작 및 끝 각도를 시계 방향으로 조정 (90도 회전)
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        // 원 중간점
        let center = CGPoint(x: rect.midX, y: rect.midY)
        // 반지름은 주어진 영역의 너비와 높이 중 더 작은 값
        let radius = min(rect.width, rect.height) / 2
        
        // 시작 점 계산 (원의 가장자리에 위치)
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.x + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        // 중심점에서 시작점으로 그림
        p.move(to: center)
        p.addLine(to: start)
        
        // 원
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        
        // 원 끝에서 다시 중심점
        p.addLine(to: center)
        
        return p
    }
}
