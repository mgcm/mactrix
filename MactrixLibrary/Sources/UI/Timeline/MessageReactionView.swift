import SwiftUI
import Models

public struct MessageReactionView<Reaction: Models.Reaction>: View {
    let reaction: Reaction
    
    public init(reaction: Reaction) {
        self.reaction = reaction
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Text(reaction.key)
            Text("\(reaction.senders.count)")
                .padding(.horizontal, 6)
        }
        .padding(4)
        .background(Color.blue.quaternary)
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.blue.tertiary)
        )
    }
}

#Preview {
    MessageReactionView(reaction: MockReaction())
        .padding()
}
