//
//  BalloonShape.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 30.09.2020.
//

import SwiftUI

struct BalloonShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let tailIncentr = CGPoint(x: R.Tail.d, y: rect.maxY - R.Radius.tail)
            let bodyRadius: CGFloat = R.Radius.balloonBody
            let start = CGPoint(x: R.Tail.d, y: rect.maxY )
            
            var p = Path()
            
            p.move(to: start)
            p.addRelativeArc(
                center: tailIncentr,
                radius: R.Radius.tail,
                startAngle: Angle(radians: .pi/2),
                delta: Angle(radians: Double(R.Tail.rotation)))
            
            p.addLine(to: CGPoint(x: R.Tail.dx, y: rect.maxY - R.Tail.dy))
            p.addLine(to: CGPoint(x: R.Tail.dx, y: rect.minY + bodyRadius))
            
            var c = CGPoint(x: R.Tail.dx + bodyRadius, y: rect.minY + bodyRadius)
            p.addRelativeArc(
                center: c,
                radius: bodyRadius,
                startAngle: Angle(radians: .pi),
                delta: Angle(radians: .pi/2))
            
            p.addLine(to: CGPoint(x: rect.maxX - bodyRadius, y: rect.minY))
            
            c = CGPoint(x: rect.maxX - bodyRadius, y: rect.minY + bodyRadius)
            p.addRelativeArc(
                center: c,
                radius: bodyRadius,
                startAngle: Angle(radians: .pi*3/2),
                delta: Angle(radians: .pi/2))
            
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bodyRadius))
            
            c = CGPoint(x: rect.maxX - bodyRadius, y: rect.maxY - bodyRadius)
            p.addRelativeArc(
                center: c,
                radius: bodyRadius,
                startAngle: Angle(radians: 0),
                delta: Angle(radians: .pi/2))
            
            path.addPath(p)
            path.closeSubpath()
        }
    }
}

struct MessageBackground_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("Hello World!")
                .padding()
                .background(Color.green)
                .clipShape(BalloonShape())
            
            BalloonShape()
                .stroke(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                .frame(width: 200, height: 60, alignment: .center)
        }
    }
}
