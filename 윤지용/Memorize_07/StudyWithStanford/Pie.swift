//
//  Pie.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 11/11/24.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero  // 시작 각도 (기본값 0)
    let endAngle: Angle           // 끝 각도
    let clockwise = true          // 회전 방향
    
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)  // 시작 각도를 90도 앞당김
        let endAngle = endAngle - .degrees(90)      // 끝 각도를 90도 앞당김
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.x + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise)
        p.addLine(to: center)
        
        return p
    }
}
