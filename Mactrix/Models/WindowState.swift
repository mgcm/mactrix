import Foundation
import MatrixRustSDK
import SwiftUI

enum InspectorContent: Equatable {
    case roomInfo
    case search
    case userInfo(userId: String)
    case roomThreads
    case roomPins
    case focusThread(threadTimeline: LiveTimeline)
}

enum SearchDirectResult {
    case lookingForRoom(alias: String), roomNotFound(alias: String)
    case resolvedRoomAlias(alias: String, resolvedRoom: MatrixRustSDK.ResolvedRoomAlias)
    case resolvedRoomId(roomPreview: MatrixRustSDK.RoomPreview)
    case lookingForUser(userId: String), userNotFound(userId: String)
    case resolvedUser(profile: MatrixRustSDK.UserProfile)
}

@MainActor @Observable
final class WindowState {
    var selectedScreen: SelectedScreen = .none

    // @SceneStorage("MainView.selectedRoomId")
    var selectedRoomId: String?

    // @SceneStorage("MainView.inspectorVisible")
    var inspectorVisible: Bool = false

    var inspectorContent: InspectorContent = .roomInfo

    var searchQuery: String = ""
    var searchTokens: [SearchToken] = []
    var searchDirectResult: SearchDirectResult?

    var searchFocused: Binding<Bool> {
        Binding(
            get: { self.inspectorContent == .search },
            set: { setFocused in
                if setFocused {
                    self.inspectorContent = .search
                    self.inspectorVisible = true
                }

                if !setFocused, self.inspectorContent == .search {
                    self.inspectorContent = .roomInfo
                }
            }
        )
    }

    func toggleInspector() {
        if inspectorVisible {
            if inspectorContent == .roomInfo {
                inspectorVisible = false
            } else {
                inspectorContent = .roomInfo
            }
        } else {
            inspectorVisible = true
            inspectorContent = .roomInfo
        }
    }

    func focusThread(rootEventId: String) {
        guard case let .joinedRoom(timeline: roomTimeline) = selectedScreen else { return }

        inspectorVisible = true
        inspectorContent = .focusThread(threadTimeline: LiveTimeline(room: roomTimeline.room, focusThread: rootEventId))
    }

    func showRoomThreads() {
        if inspectorVisible, inspectorContent == .roomThreads {
            inspectorVisible = false
        } else {
            inspectorContent = .roomThreads
            inspectorVisible = true
        }
    }

    func showRoomPins() {
        if inspectorVisible, inspectorContent == .roomPins {
            inspectorVisible = false
        } else {
            inspectorContent = .roomPins
            inspectorVisible = true
        }
    }

    func focusUser(userId: String) {
        if inspectorVisible, inspectorContent == .userInfo(userId: userId) {
            inspectorVisible = false
        } else {
            inspectorContent = .userInfo(userId: userId)
            inspectorVisible = true
        }
    }
}

enum SearchToken: Hashable, Identifiable {
    case users, rooms, spaces, messages
    case resolvedRoomAlias(alias: String, resolvedRoom: ResolvedRoomAlias)
    case resolvedRoomId(roomPreview: RoomPreview)
    case resolvedUser(profile: UserProfile)

    var id: Self { self }
}
