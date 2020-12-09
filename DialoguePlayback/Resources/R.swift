//
//  R.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 29.09.2020.
//
import SwiftUI

struct R {
    static let dialogueViewTitle = "'The Golden Circle'"
    static let background = Color("background")
    static let maxCharacters = 550
    static let animationDuration: Double = 0.5
    static let preUtteranceDelay: Double = 0.5
    static let messageLeadingPadding: CGFloat = 20.0
    static let messageStackSpacing: CGFloat = 30.0
    static let messageTextPadding: CGFloat = 10.0
}

extension R {
    struct balloon {
        static let radius: CGFloat = 5.0
        static let color = Color("balloon")
    }

    struct tail {
        static let dx: CGFloat = 11.0
        static let dy: CGFloat = 18.0
        static let c: CGFloat = hypot(dx, dy)
        static let r: CGFloat = (dx + dy - c) / 2
        static let d: CGFloat = (c + dx - dy) / 2
        static let startY: CGFloat = (dy / dx) * startX
        static let startX: CGFloat = 2
        static let alpha: CGFloat = atan2(dy, dx)
        static let rotation: CGFloat = CGFloat.pi - alpha        
    }
    
    struct shadow {
        static let color: Color = Color("balloonShadow")
        static let radius: CGFloat = 4.0
        static let x: CGFloat = 1.0
        static let y: CGFloat = 1.0
    }
    
    struct font {
        static let size: CGFloat = 17.0
        static let family: String = "SF Pro Text"
    }
}
