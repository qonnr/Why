//
//  DialoguePlaybackApp.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 25.09.2020.
//

import SwiftUI

@main
struct DialoguePlaybackApp: App {
    var body: some Scene {
        WindowGroup {
            Dialogue()
                .environment(\.colorScheme, .light)
            
        }
    }
}
