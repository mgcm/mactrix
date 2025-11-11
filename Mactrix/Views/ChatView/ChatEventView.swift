import SwiftUI
import MatrixRustSDK

struct StateEventView: View {
    
    let event: EventTimelineItem
    let stateKey: String
    let state: OtherState
    
    var stateMessage: String {
        switch state {
        case .policyRuleRoom:
            "changed policy rules for room"
        case .policyRuleServer:
            "changed policy rules for server"
        case .policyRuleUser:
            "changed policy rule for user"
        case .roomAliases:
            "changed room aliases"
        case .roomAvatar(url: _):
            "changed room avatar"
        case .roomCanonicalAlias:
            "changed room canonical alias"
        case .roomCreate:
            "created room"
        case .roomEncryption:
            "changed room encryption"
        case .roomGuestAccess:
            "changed room guest access"
        case .roomHistoryVisibility:
            "change room history visibility"
        case .roomJoinRules:
            "changed room join rules"
        case .roomName(name: let name):
            "changed room name to '\(name ?? "empty")'"
        case .roomPinnedEvents(change: _):
            "changed room pinned events"
        case .roomPowerLevels(users: _, previous: _):
            "changed room power levels"
        case .roomServerAcl:
            "changed room server acl"
        case .roomThirdPartyInvite(displayName: _):
            "changed room third party invite"
        case .roomTombstone:
            "room tombstone"
        case .roomTopic(topic: let topic):
            "changed room topic to '\(topic ?? "none")'"
        case .spaceChild:
            "changed space child"
        case .spaceParent:
            "changed space parent"
        case .custom(eventType: let eventType):
            "changed custom state '\(eventType)'"
        }
    }
    
    var body: some View {
        HStack {
            (Text(event.sender).bold() + Text(" changed " + stateMessage))
                .italic()
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}


