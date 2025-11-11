import SwiftUI
import Models

public struct GenericEventView: View {
    let event: EventTimelineItem
    let name: String
    
    public init(event: EventTimelineItem, name: String) {
        self.event = event
        self.name = name
    }
    
    public var body: some View {
        HStack {
            Text("\(event.date.formatted(date: .omitted, time: .shortened)), \(Text(event.sender).bold()): \(Text(name).italic())")
                .textSelection(.enabled)
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    GenericEventView(event: MockEventTimelineItem(), name: "Test Event")
        .padding()
}
