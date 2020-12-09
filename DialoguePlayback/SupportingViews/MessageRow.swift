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
            .font(.system(size: R.font.size))
            .padding(EdgeInsets(top: R.messageTextPadding, leading: R.messageTextPadding + R.tail.dx, bottom: R.messageTextPadding, trailing: R.messageTextPadding + R.tail.dx))
            .background(R.balloon.color)
            .clipShape(BalloonShape())
            .shadow(color: R.shadow.color,
                    radius: R.shadow.radius,
                    x: R.shadow.x,
                    y: R.shadow.y)
    }
}

struct DialogueItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageRow(message: .init(text: "Hellow SwiftUI World!"))
        }
    }
}
