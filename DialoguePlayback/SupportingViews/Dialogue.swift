//
//  Dialogue.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 25.09.2020.
//

import SwiftUI
import Combine

struct Dialogue: View {
    @EnvironmentObject var appData: AppData<Fetcher>
    @State private var anyCancellable: AnyCancellable? = nil
    
    var body: some View {
            NavigationView {
                VStack(alignment: .leading)
                {
                    ForEach(appData.messages) { item in
                        MessageRow(message: item)
                    }
                }.navigationBarTitle(R.dialogueViewTitle, displayMode: .inline)
            }
        }
}

extension Dialogue {
    func messagePublisher() -> AnyPublisher<Message, Never> {
        let publishers = appData.messages
            .map { Just($0).delay(for: .seconds(1),
                                  scheduler: DispatchQueue.main).eraseToAnyPublisher() }
        return publishers[1...]
            .reduce(publishers[0]) {
                Publishers.Concatenate(prefix: $0, suffix: $1).eraseToAnyPublisher()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dialogue()
            .environmentObject(AppData<Fetcher>())
    }
}
