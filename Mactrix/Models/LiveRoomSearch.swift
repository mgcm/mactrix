import Foundation
import MatrixRustSDK

@MainActor @Observable
class LiveRoomSearch {
    let roomDirectorySearch: RoomDirectorySearchProtocol

    @ObservationIgnored
    fileprivate var resultsTaskHandle: TaskHandle?

    var rooms: [RoomDescription] = []

    init(roomDirectorySearch: RoomDirectorySearchProtocol) {
        self.roomDirectorySearch = roomDirectorySearch
        Task {
            resultsTaskHandle = await roomDirectorySearch.results(listener: self)
        }
    }

    func search(query: String?) async throws {
        try await roomDirectorySearch.search(filter: query, batchSize: 100, viaServerName: nil)
    }
}

extension LiveRoomSearch: RoomDirectorySearchEntriesListener {
    nonisolated func onUpdate(roomEntriesUpdate: [MatrixRustSDK.RoomDirectorySearchEntryUpdate]) {
        Task { @MainActor in
            for update in roomEntriesUpdate {
                switch update {
                case let .append(values):
                    rooms.append(contentsOf: values)
                case .clear:
                    rooms.removeAll()
                case let .pushFront(room):
                    rooms.insert(room, at: 0)
                case let .pushBack(room):
                    rooms.append(room)
                case .popFront:
                    rooms.removeFirst()
                case .popBack:
                    rooms.removeLast()
                case let .insert(index, room):
                    rooms.insert(room, at: Int(index))
                case let .set(index, room):
                    rooms[Int(index)] = room
                case let .remove(index):
                    rooms.remove(at: Int(index))
                case let .truncate(length):
                    rooms.removeSubrange(Int(length) ..< rooms.count)
                case let .reset(values: values):
                    rooms = values
                }
            }
        }
    }
}
