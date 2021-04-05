//
//  MessageRow.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 30.09.2020.
//

import SwiftUI
import Combine

struct MessageRow: View {
    var message: Message
    @Binding var delivered: PassthroughSubject<Void, Never>
    /// ###
    @State private var opacityValue = 0.0
    var body: some View {
        Text(message.text.prefix(R.maxCharacters))
            .font(.system(size: R.Font.size))
            .padding(R.Insets.message)
            .background(R.Color.balloon)
            .clipShape(BalloonShape())
            .shadow(color: R.Color.shadow,
                    radius: R.Radius.messageShadow,
                    x: R.Shadow.x,
                    y: R.Shadow.y)
            .opacity(opacityValue)
            .onAppear() {
                opacityValue = 1.0
            }
            .onCompleteAnimation(for: opacityValue) { delivered.send() }        
    }
}

struct DialogueItem_Previews: PreviewProvider {
    @State static var mockSubj = PassthroughSubject<Void, Never>()
    static var previews: some View {
        Group {
            MessageRow(message: .init(text: "Hellow SwiftUI World!"), delivered: $mockSubj)
        }
    }
}
