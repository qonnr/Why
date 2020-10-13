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

    @State private var inputStream: [Message] = []
    @State private var anyCancellable: AnyCancellable? = nil

    var body: some View {
        NavigationView {
            LazyVStack(alignment: .leading, spacing: R.messageStackSpacing)
            {
                ForEach(inputStream) { item in
                    MessageRow(message: item)
                }
                .transition(.move(edge: .bottom))
            }
            .navigationBarTitle(R.dialogueViewTitle, displayMode: .inline)
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .onAppear() {
                anyCancellable = messagePublisher().sink(receiveValue: { value in
                    inputStream.append(value)
                })
            }
            .animation(.linear(duration: R.animationDuration))
            .padding(R.dialogueViewPadding)
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
