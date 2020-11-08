//
//  M.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 03.10.2020.
//
import Foundation
import AVKit
import Combine

protocol Loader {
    static func load() -> [Message]
}

struct Message: Identifiable {
    var id = UUID()
    var text: String
}

class AppData<T: Loader>: ObservableObject {
    @Published var messages: [Message] = T.load()
}

extension AppData {
    func messagePublisher() -> AnyPublisher<Message, Never> {
        let publishers = messages
            .map { Just($0).delay(for: .seconds(1),
                                  scheduler: DispatchQueue.main).eraseToAnyPublisher() }
        return publishers[1...]
            .reduce(publishers[0]) {
                Publishers.Concatenate(prefix: $0, suffix: $1).eraseToAnyPublisher()
            }
    }
}

class Player: NSObject, AVSpeechSynthesizerDelegate {
    private func playback(_ text: String) {
        let speaker = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.preUtteranceDelay = R.preUtteranceDelay
        speaker.speak(utterance)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
    }
}
