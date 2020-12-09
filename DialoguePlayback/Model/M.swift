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

struct Message: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var opacity = 0.0
}

class AppData<T: Loader>: ObservableObject {
    ///
    private var messages: [Message] = T.load()
    ///
}

extension AppData {
    func messagePub() -> AnyPublisher<Message, Never>? {
        let publishers = messages.map { message in
            Just(message).eraseToAnyPublisher()
        }
        return publishers.first.map { publishers.dropFirst().reduce($0) {
            $0.append($1).eraseToAnyPublisher()
        } }
    }
}
