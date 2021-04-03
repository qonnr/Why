//
//  Fetcher.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 11.10.2020.
//

import Foundation

struct S {
    static func load<Item: Decodable>(_ filename: String) -> Item {
        let data: Data
    
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Item.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Item.self):\n\(error)")
        }
    }
}

struct Fetcher {
}

private extension Fetcher {
    struct DialogueScenario: Codable {
        let line: String
    }
}

extension Fetcher {
    struct Basic: Loader {
        static func load() -> [Message] {
            let scenario: [DialogueScenario] = S.load("testRealQuick.json")
            return scenario.map { Message(text: $0.line) }
        }
    }
}

extension Fetcher {
    struct Full: Loader {
        static func load() -> [Message] {
            let scenario: [DialogueScenario] = S.load("startWithWhy.json")
            return scenario.map { Message(text: $0.line) }
        }
    }
}


