import Foundation
import MatrixRustSDK
import Models
import OSLog

@MainActor @Observable
public final class LiveRoom: Identifiable {
    let sidebarRoom: SidebarRoom

    public var typingUserIds: [String] = []
    public var fetchedMembers: [MatrixRustSDK.RoomMember]?

    private var typingHandle: TaskHandle?

    public let room: MatrixRustSDK.Room

    public var roomInfo: MatrixRustSDK.RoomInfo? {
        sidebarRoom.roomInfo
    }

    public nonisolated var id: String {
        room.id()
    }

    public init(sidebarRoom: SidebarRoom) {
        self.sidebarRoom = sidebarRoom
        self.room = sidebarRoom.room
    }

    public convenience init(matrixRoom: MatrixRustSDK.Room) {
        self.init(sidebarRoom: SidebarRoom(room: matrixRoom))
    }

    fileprivate func startListening() {
        typingHandle = room.subscribeToTypingNotifications(listener: self)
    }
}

extension LiveRoom: TypingNotificationsListener {
    public nonisolated func call(typingUserIds: [String]) {
        Task { @MainActor in
            self.typingUserIds = typingUserIds
        }
    }
}

extension LiveRoom: Hashable {
    public nonisolated static func == (lhs: LiveRoom, rhs: LiveRoom) -> Bool {
        lhs.id == rhs.id
    }

    public nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension LiveRoom: Models.Room {
    public nonisolated func syncMembers() async throws {
        Task { @MainActor in
            // guard not already synced
            guard fetchedMembers == nil else { return }

            let id = self.id
            Logger.liveRoom.debug("syncing members for room: \(id)")

            let memberIter = try await room.members()
            var result = [MatrixRustSDK.RoomMember]()
            while let memberChunk = memberIter.nextChunk(chunkSize: 1000) {
                result.append(contentsOf: memberChunk)
            }
            fetchedMembers = result

            Logger.liveRoom.debug("synced \(result.count) members")
        }
    }

    public nonisolated var displayName: String? {
        room.displayName()
    }

    public nonisolated var topic: String? {
        room.topic()
    }

    public nonisolated var encryptionState: Models.EncryptionState {
        room.encryptionState().asModel
    }
}
