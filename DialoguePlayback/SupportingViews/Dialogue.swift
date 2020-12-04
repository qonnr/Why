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
            LazyVStack
            {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: R.messageStackSpacing) {
                        ForEach(inputStream) { item in
                            MessageRow(message: item)
                        }
                    }.padding(R.balloon.radius)
                }.animation(.linear(duration: R.animationDuration))
            }
            .navigationBarTitle(R.dialogueViewTitle, displayMode: .inline)
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .bottom)    
            .onAppear() {
                anyCancellable = appData.messagePublisher()?.sink(receiveValue: { value in
                    inputStream.append(value)
                })
            }.padding(R.dialogueViewPadding)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dialogue()
            .environmentObject(AppData<Fetcher>())
    }
}
