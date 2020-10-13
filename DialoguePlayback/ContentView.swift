//
//  ContentView.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 25.09.2020.
//

import SwiftUI

struct DialogueView: View {
    var body: some View {
        ZStack {
            MessageBg()
            Text("""
                Hello, world!
                Lorem ipsum est dolor, Lorem ipsum est dolor
                """)
        }
        .scaledToFit()
    }
}

struct MessageBg: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let rect = CGRect(origin: CGPoint.zero, size: geometry.size)
                let startPoint = CGPoint(x: R.Balloon.Source.offsetWidth,
                                         y: rect.maxY - R.Balloon.Source.offsetHeight)
                
                path.move(to: startPoint)
                
                path.addLine(to: CGPoint(x: 0, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX - R.Balloon.radius, y: rect.maxY))
                
                path.addArc(center: CGPoint(x: rect.maxX - R.Balloon.radius, y: rect.maxY - R.Balloon.radius),
                            radius: R.Balloon.radius,
                            startAngle: Angle(radians: Double.pi / 2),
                            endAngle: Angle(radians: 0),
                            clockwise: true)
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + R.Balloon.radius))
                path.addArc(center: CGPoint(x: rect.maxX - R.Balloon.radius, y: rect.minY + R.Balloon.radius),
                            radius: R.Balloon.radius,
                            startAngle: Angle(radians: 0),
                            endAngle: Angle(radians: 3 * Double.pi / 2),
                            clockwise: true)
                path.addLine(to: CGPoint(x: rect.minX + R.Balloon.radius + R.Balloon.Source.offsetWidth,
                                         y: rect.minY))
                path.addArc(center: CGPoint(x: rect.minX + R.Balloon.radius + R.Balloon.Source.offsetWidth,
                                            y: rect.minY + R.Balloon.radius),
                            radius: R.Balloon.radius,
                            startAngle: Angle(radians: 3 * Double.pi / 2),
                            endAngle: Angle(radians: Double.pi),
                            clockwise: true)
            }
            .fill(R.Balloon.color)
            .shadow(color: R.Balloon.Shadow.color,
                    radius: R.Balloon.Shadow.radius,
                    x: R.Balloon.Shadow.x,
                    y: R.Balloon.Shadow.y)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DialogueView()
    }
}
