//
//  Fetcher.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 11.10.2020.
//

import Foundation

struct Fetcher: Loader {
    static func load() -> [Message] {
        let scenario: [DialogueScenario] = S.load("dialogueScenario.json")
        return scenario.map { Message(text: $0.line) }
    }
}

private extension Fetcher {
    struct DialogueScenario: Codable {
        let line: String
    }
}
