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
            let dxRect = rect.insetBy(dx: R.tail.dx, dy: 0)
            let body = UIBezierPath(roundedRect: dxRect,
                                    byRoundingCorners: bodyCorners,
                                    cornerRadii: bodyRadii)
            path.addPath(Path(body.cgPath))
            var tail = Path()
            let startPoint = CGPoint(x: R.tail.dx,
                                     y: rect.maxY - R.tail.dy)
            tail.move(to: startPoint)
            tail.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            tail.addLine(to: CGPoint(x: R.tail.dx, y: rect.maxY))
            path.addPath(tail)
        }
    }
}

extension BalloonShape {
    var bodyRadii: CGSize { CGSize(width: R.balloon.radius, height: R.balloon.radius) }
    var bodyCorners: UIRectCorner { [.topLeft, .topRight, .bottomRight] }
}

struct MessageBackground_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World!")
            .padding()
            .background(Color.green)
            .clipShape(BalloonShape())
            
    }
}
