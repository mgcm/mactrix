import Foundation
import MatrixRustSDK
import OSLog

@MainActor @Observable
public final class SidebarRoom: Identifiable {
    public let room: MatrixRustSDK.Room
    public var roomInfo: RoomInfo?

    public nonisolated var id: String {
        room.id()
    }

    public init(room: MatrixRustSDK.Room) {
        self.room = room
        subscribeRoomInfo()
    }

    @ObservationIgnored
    private var roomInfoHandle: TaskHandle?

    fileprivate func subscribeRoomInfo() {
        Task {
            do {
                self.roomInfo = try await self.room.roomInfo()
                self.roomInfoHandle = room.subscribeToRoomInfoUpdates(listener: self)
            } catch {
                Logger.viewCycle.error("Failed to load room info: \(error)")
            }
        }
    }
}

extension SidebarRoom: MatrixRustSDK.RoomInfoListener {
    public nonisolated func call(roomInfo: MatrixRustSDK.RoomInfo) {
        Task { @MainActor in
            self.roomInfo = roomInfo
        }
    }
}
