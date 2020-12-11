//
//  Player.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 09.12.2020.
//
import SwiftUI
import AVKit

class Player: NSObject, AVSpeechSynthesizerDelegate {
    private var utterance: AVSpeechUtterance?
    ///
    @Published var isPlaying = false
    lazy var speaker: AVSpeechSynthesizer = {
        let speaker = AVSpeechSynthesizer()
        speaker.delegate = self
        return speaker
    }()
    ///
    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer, didFinish
            utterance: AVSpeechUtterance) {
        isPlaying = false
    }
    ///
    func push(_ text: String) {
        utterance = AVSpeechUtterance(string: text)
    }
    ///
    func pop() {
        utterance.map { speaker.speak($0) }
    }
}


