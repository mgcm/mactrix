import MatrixRustSDK
import Models
import SwiftUI
import UI

struct ChatMessageView: View, UI.MessageEventActions {
    @Environment(AppState.self) private var appState
    @Environment(WindowState.self) private var windowState

    let timeline: LiveTimeline
    let event: MatrixRustSDK.EventTimelineItem
    let msg: MatrixRustSDK.MsgLikeContent

    var name: String {
        if case let .ready(displayName, _, _) = event.senderProfileDetails, let displayName = displayName {
            return displayName
        }
        return event.sender
    }

    func toggleReaction(key: String) {
        Task {
            do {
                let _ = try await timeline.timeline?.toggleReaction(itemId: event.eventOrTransactionId, key: key)
            } catch {
                print("Failed to toggle reaction: \(error)")
            }
        }
    }

    func reply() {}

    func replyInThread() {}

    func pin() {
        guard case let .eventId(eventId: eventId) = event.eventOrTransactionId else { return }
        Task {
            do {
                let _ = try await timeline.timeline?.pinEvent(eventId: eventId)
            } catch {
                print("Failed to ping message: \(error)")
            }
        }
    }

    @ViewBuilder
    var message: some View {
        switch msg.kind {
        case let .message(content: content):
            switch content.msgType {
            case let .emote(content: content):
                Text("Emote: \(content.body)").textSelection(.enabled)
            case let .image(content: content):
                MessageImageView(content: content)
            case let .audio(content: content):
                Text("Audio: \(content.caption ?? "no caption") \(content.filename)").textSelection(.enabled)
            case let .video(content: content):
                Text("Video: \(content.caption ?? "no caption") \(content.filename)").textSelection(.enabled)
            case let .file(content: content):
                Text("File: \(content.caption ?? "no caption") \(content.filename)").textSelection(.enabled)
            case let .gallery(content: content):
                Text("Gallery: \(content.body)").textSelection(.enabled)
            case let .notice(content: content):
                Text("Notice: \(content.body)").textSelection(.enabled)
            case let .text(content: content):
                Text(content.body).textSelection(.enabled)
            case let .location(content: content):
                Text("Location: \(content.body) \(content.geoUri)").textSelection(.enabled)
            case let .other(msgtype: msgtype, body: body):
                Text("Other: \(msgtype) \(body)").textSelection(.enabled)
            }
        case .sticker(body: let body, info: _, source: _):
            Text("Sticker: \(body)").textSelection(.enabled)
        case .poll(question: let question, kind: _, maxSelections: _, answers: _, votes: _, endTime: _, hasBeenEdited: _):
            Text("Poll: \(question)").textSelection(.enabled)
        case .redacted:
            Text("Message redacted")
                .italic()
                .foregroundStyle(.secondary)
                .textSelection(.enabled)
        case .unableToDecrypt(msg: _):
            Text("Unable to decrypt")
                .italic()
                .foregroundStyle(.secondary)
                .textSelection(.enabled)
        case .other(eventType: _):
            Text("Custom event").textSelection(.enabled)
        }
    }

    @ViewBuilder
    func embeddedMessageView(embeddedEvent: MatrixRustSDK.EmbeddedEventDetails, action: @escaping () -> Void) -> some View {
        switch embeddedEvent {
        case .unavailable, .pending:
            UI.MessageReplyView(
                username: "loading@username.org",
                message: "Phasellus sit amet purus ac enim semper convallis. Nullam a gravida libero.",
                action: action
            )
            .redacted(reason: .placeholder)
        case let .ready(content, sender, _, _, _):
            switch content {
            case let .msgLike(content):
                switch content.kind {
                case let .message(content):
                    UI.MessageReplyView(username: sender, message: content.body, action: action)
                case let .sticker(body, _, _):
                    UI.MessageReplyView(username: sender, message: body, action: action)
                case let .poll(question, _, _, _, _, _, _):
                    UI.MessageReplyView(username: sender, message: question, action: action)
                case .redacted:
                    UI.MessageReplyView(username: sender, message: "redacted", action: action)
                case .unableToDecrypt:
                    UI.MessageReplyView(username: sender, message: "unable to decrypt", action: action)
                case .other:
                    UI.MessageReplyView(username: sender, message: "other event", action: action)
                }
            case .callInvite:
                UI.MessageReplyView(username: sender, message: "call invite", action: action)
            case .rtcNotification:
                UI.MessageReplyView(username: sender, message: "rtc notification", action: action)
            case .roomMembership:
                UI.MessageReplyView(username: sender, message: "room membership", action: action)
            case .profileChange:
                UI.MessageReplyView(username: sender, message: "profile change", action: action)
            case .state:
                UI.MessageReplyView(username: sender, message: "state change", action: action)
            case .failedToParseMessageLike:
                UI.MessageReplyView(username: sender, message: "failed to parse message", action: action)
            case .failedToParseState:
                UI.MessageReplyView(username: sender, message: "failed to parse state", action: action)
            }
        case let .error(message):
            Text("error: \(message)")
        }
    }
    
    var isEventFocused: Bool {
        guard let focusedEventId = timeline.focusedTimelineEventId else { return false }
        return focusedEventId == event.eventOrTransactionId.id
    }

    var body: some View {
        UI.MessageEventView(event: event, focused: isEventFocused, reactions: msg.reactions, actions: self, imageLoader: appState.matrixClient) {
            VStack(alignment: .leading, spacing: 20) {
                if msg.inReplyTo != nil || msg.threadRoot != nil || msg.threadSummary != nil {
                    VStack(alignment: .leading) {
                        if let replyTo = msg.inReplyTo {
                            embeddedMessageView(embeddedEvent: replyTo.event()) {
                                timeline.focusEvent(id: replyTo.eventId())
                            }
                        }

                        if let threadSummary = msg.threadSummary {
                            Text("Thread summary (\(threadSummary.numReplies()) messages)")
                                .italic()
                            embeddedMessageView(embeddedEvent: threadSummary.latestEvent()) {
                                timeline.focusThread(rootEventId: event.eventOrTransactionId.id)
                                windowState.inspectorVisible = true
                            }
                        }
                    }
                    .foregroundStyle(.gray)
                }

                message
            }
        }
    }
}
