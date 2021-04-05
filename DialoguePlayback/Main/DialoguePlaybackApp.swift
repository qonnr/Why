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
// MARK: - Animation
struct AM<Value>: AnimatableModifier where Value: VectorArithmetic {
    ///
    var animatableData: Value {
        didSet {
            handleCompletion()
        }
    }
    ///
    private var target: Value
    private var handler: () -> Void
    ///
    init(observedValue: Value, completion: @escaping () -> Void) {
        self.handler = completion
        self.animatableData = observedValue
        target = observedValue
    }
    ///
    private func handleCompletion() {
        guard animatableData == target else { return }
        
        DispatchQueue.main.async {
            self.handler()
        }
    }
    ///
    func body(content: Content) -> some View {
        return content
    }
}

extension View {
    func onCompleteAnimation<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AM<Value>> {
        return modifier(AM(observedValue: value, completion: completion))
    }
}

