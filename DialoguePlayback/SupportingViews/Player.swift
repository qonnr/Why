//
//  Player.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 09.12.2020.
//
import SwiftUI
import AVKit

class Player: NSObject, AVSpeechSynthesizerDelegate {
    @Published var isPlaying = false

    lazy var speaker: AVSpeechSynthesizer = {
        let speaker = AVSpeechSynthesizer()
        speaker.delegate = self
        return speaker
    }()
    ///
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isPlaying = false
    }
}


