//
//  M.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 03.10.2020.
//
import Foundation

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

