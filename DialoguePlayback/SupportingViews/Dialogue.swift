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
                anyCancellable = appData.messagePublisher().sink(receiveValue: { value in
                    inputStream.append(value)
                })
            }
            .animation(.linear(duration: R.animationDuration))
            .padding(R.dialogueViewPadding)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dialogue()
            .environmentObject(AppData<Fetcher>())
    }
}
