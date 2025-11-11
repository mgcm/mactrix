import SwiftUI
import Models

struct HoverButton: View {
    
    @State private var hovering = false
    
    let icon: String
    let tooltip: LocalizedStringKey
    let action: () -> Void
    
    let size: CGFloat = 20.0
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
        }
        .buttonStyle(.plain)
        .help(tooltip)
        .foregroundStyle(hovering ? Color.accentColor : .primary)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.accentColor.quaternary)
                .frame(width: size, height: size)
                .opacity(hovering ? 1 : 0)
        )
        .frame(width: size, height: size)
        .padding(2)
        .onHover { hover in
            hovering = hover
        }
    }
}

public struct MessageEventView<MessageView: View, EventTimelineItem: Models.EventTimelineItem, Reaction: Models.Reaction>: View {
    
    let event: EventTimelineItem
    let reactions: [Reaction]
    let message: MessageView
    
    public init(event: EventTimelineItem, reactions: [Reaction], @ViewBuilder message: () -> MessageView) {
        self.event = event
        self.reactions = reactions
        self.message = message()
    }
    
    var name: String {
        if case let .ready(displayName, _, _) = event.senderProfileDetails, let displayName = displayName {
            return displayName
        }
        return event.sender
    }
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    @State private var hoverText: Bool = false
    
    @ViewBuilder
    var hoverActions: some View {
        HStack(spacing: 0) {
            HoverButton(icon: "face.smiling", tooltip: "React") {}
            HoverButton(icon: "arrowshape.turn.up.left", tooltip: "Reply") {}
            HoverButton(icon: "ellipsis.message", tooltip: "Reply in thread") {}
            HoverButton(icon: "pin", tooltip: "Pin") {}
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(NSColor.controlBackgroundColor))
                .stroke(Color(NSColor.separatorColor), lineWidth: 1)
                .shadow(color: .black.opacity(0.1), radius: 4)
        )
        .padding(.trailing, 20)
        .padding(.top, 8)
        .opacity(hoverText ? 1 : 0)
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                // Profile icon and name
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Circle()
                            .frame(width: 32, height: 32)
                        
                    }.frame(width: 64)
                    
                    Text(name)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                // Main body
                HStack(alignment: .top, spacing: 0) {
                    HStack {
                        Text(timeFormat.string(from: event.date))
                            .foregroundStyle(.gray)
                            .font(.system(.footnote))
                            .padding(.trailing, 5)
                            .padding(.top, 3)
                    }
                    .frame(width: 64 - 10)
                    .opacity(hoverText ? 1 : 0)
                    message
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.1))
                        .opacity(hoverText ? 1 : 0)
                )
                .padding(.horizontal, 10)
                
                // Reactions
                HStack {
                    Spacer().frame(width: 64)
                    ForEach(reactions) { reaction in
                        MessageReactionView(reaction: reaction)
                    }
                    Spacer()
                }
                .padding(.top, 10)
            }
            
            hoverActions
        }
        .padding(.top, 5)
        .onHover { hover in
            hoverText = hover
        }
    }
}

#Preview {
    MessageEventView(event: MockEventTimelineItem(), reactions: [MockReaction()]) {
        Text("This is the body of the message")
    }
    .padding(.vertical)
}
