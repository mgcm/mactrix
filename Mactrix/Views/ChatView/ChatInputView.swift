import SwiftUI

struct ChatInputView: View {
    
    @State private var chatInput: String = ""
    
    var body: some View {
        VStack {
            TextField("Message room", text: $chatInput, axis: .vertical)
                .textFieldStyle(.plain)
                .lineLimit(nil)
                .scrollContentBackground(.hidden)
                .background(.clear)
                .padding(10)
        }
        .font(.system(size: 14))
        .background(Color(NSColor.textBackgroundColor))
        .cornerRadius(4)
        .lineSpacing(2)
        .frame(minHeight: 20)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color(NSColor.separatorColor), lineWidth: 1)
        )
        //.shadow(color: .black.opacity(0.1), radius: 4)
        .padding([.horizontal, .bottom], 10)
        .background(Color(NSColor.controlBackgroundColor))
    }
}

#Preview {
    ChatInputView()
}
