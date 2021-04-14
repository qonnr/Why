//
//  Dialogue.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 25.09.2020.
//
import SwiftUI
import Combine

struct Dialogue: View {
    /// ###
    var body: some View {
        NavigationView {
            ZStack {
                R.Color.background
                MsgList()
            }
        }
    }
}
/// ###
struct MsgList: View {
    @StateObject var msg = MsgStore()
    /// ###
    var body: some View {
        LazyVStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(msg.feed) { item in
                        MessageRow(message: item)
                            .padding(R.Insets.balloon)
                            .environmentObject(msg)
                    }
                }
            }
            .animation(.linear(duration: R.Seconds.animation))
        }
        .navigationBarTitle(R.Strings.title, displayMode: .inline)
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity,
               minHeight: 0, idealHeight: .infinity, maxHeight: .infinity,
               alignment: .bottom)
    }
}
/// ###
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dialogue()
    }
}
