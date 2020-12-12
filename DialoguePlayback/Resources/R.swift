//
//  R.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 29.09.2020.
//
import SwiftUI

struct R {
    static let dialogueViewTitle = "'The Golden Circle'"
    static let maxCharacters = 550
}

extension R {
    struct Tail {
        static let dx: CGFloat = 11.0
        static let dy: CGFloat = 18.0
        static let c: CGFloat = hypot(dx, dy)
        static let d: CGFloat = (c + dx - dy) / 2
        static let rotation: CGFloat = CGFloat.pi - atan2(dy, dx)
    }
    
    struct Shadow {
        static let x: CGFloat = 1.0
        static let y: CGFloat = 1.0
    }
    
    struct Font {
        static let size: CGFloat = 17.0
        static let family: String = "SF Pro Text"
    }
}

extension R {
    struct Insets {
        private static let messageLeadingPadding: CGFloat = 20.0
        private static let messageStackSpacing: CGFloat = 30.0
        private static let messageTextPadding: CGFloat = 10.0
        static let balloon
            = EdgeInsets(
                top: messageStackSpacing / 2.0,
                leading: messageLeadingPadding,
                bottom: messageStackSpacing / 2.0,
                trailing: messageLeadingPadding)
        static let message
            = EdgeInsets(
                top: messageTextPadding,
                leading: messageTextPadding + R.Tail.dx,
                bottom: messageTextPadding,
                trailing: messageTextPadding + R.Tail.dx)
    }
}

extension R {
    struct Color {
        static let shadow = SwiftUI.Color("balloonShadow")
        static let balloon = SwiftUI.Color("balloon")
        static let background = SwiftUI.Color("background")
    }
}

extension R {
    struct Seconds {
        static let animation: Double = 0.5
        static let preUtterance: Double = 0.5
    }
}

extension R {
    struct Radius {
        static let balloonBody: CGFloat = 5.0
        static let messageShadow: CGFloat = 4.0
        static let tail: CGFloat = (Tail.dx + Tail.dy - Tail.c) / 2.0
    }
}
