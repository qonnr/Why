//
//  MessageRow.swift
//  DialoguePlayback
//
//  Created by Alexander Kutsan on 30.09.2020.
//

import SwiftUI

struct MessageRow: View {
    var message: Message
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
    }
}

struct DialogueItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageRow(message: .init(text: "Hellow SwiftUI World!"))
        }
    }
}
