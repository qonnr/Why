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
/// ### Model
struct Message: Identifiable {
    var id = UUID()
    var text: String
}
/// ### App's data essentials
class MsgStore: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    /// ###
    @Published public private(set) var feed: [Message] = []
    /// ###
    public private(set) var delivered = PassthroughSubject<Void, Never>()
    /// ###
    private var cache: [Message] = Fetcher.Full.load()
    /// ###
    private var bag = Set<AnyCancellable>()
    /// ###
    override init() {
        super.init()
        
        let pubs = cache
            .map { Just($0).eraseToAnyPublisher() }
        let temp = pubs
            .first
            .map { pubs.dropFirst().reduce($0) { $0.append($1).eraseToAnyPublisher() } }
        
        guard let values = temp else { return }
        
        values
            .zip(delivered).map(\.0)
            .delay(for: .seconds(R.Seconds.preUtterance), scheduler: DispatchQueue.main)
            .zip($isPlaying).compactMap { $0.1 == false ? $0.0 : nil }
            .sink { [self] in
                feed.append($0)
                utterance = AVSpeechUtterance(string:  String($0.text.prefix(R.maxCharacters))) }
            .store(in: &bag)
        
        delivered
            .delay(for: .seconds(R.Seconds.preUtterance), scheduler: RunLoop.main)
            .sink { [self] in utterance.map { speaker.speak($0) } }
            .store(in: &bag)
        // To kick-off
        delivered.send()
    }
    /// ### AVKit
    @Published private var isPlaying = false
    /// ###
    private var utterance: AVSpeechUtterance?
    /// ###
    private lazy var speaker: AVSpeechSynthesizer = {
        let speaker = AVSpeechSynthesizer()
        speaker.delegate = self
        return speaker
    }()
    /// ###
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isPlaying = false
    }
}
