//
//  Dialogue.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 25.09.2020.
//
import SwiftUI
import Combine

struct Dialogue: View {
    @StateObject var msg = MsgStore()
    /// ###
    var body: some View {
        NavigationView {
            ZStack {
                R.Color.background
                LazyVStack {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(msg.feed) { item in
                                MessageRow(message:
                                            item)
                                    .opacity(item.opacity)
                                    .onCompleteAnimation(for: item.opacity) {
                                        msg.delivered.send()
                                    }
                                    .padding(R.Insets.balloon)
                                    .onAppear {
                                        withAnimation(.linear(duration: R.Seconds.animation)) {
                                            msg.feed.firstIndex { $0.id == item.id }
                                                .map { msg.feed[$0].opacity = 1.0 }
                                        }
                                    }
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
    }
}
/// ###
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Dialogue()
    }
}
// MARK: - Animation
struct AM<Value>: AnimatableModifier where Value: VectorArithmetic {
    ///
    var animatableData: Value {
        didSet {
            handleCompletion()
        }
    }
    ///
    private var target: Value
    private var handler: () -> Void
    ///
    init(observedValue: Value, completion: @escaping () -> Void) {
        self.handler = completion
        self.animatableData = observedValue
        target = observedValue
    }
    ///
    private func handleCompletion() {
        guard animatableData == target else { return }
        
        DispatchQueue.main.async {
            self.handler()
        }
    }
    ///
    func body(content: Content) -> some View {
        return content
    }
}

extension View {
    func onCompleteAnimation<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AM<Value>> {
        return modifier(AM(observedValue: value, completion: completion))
    }
}
