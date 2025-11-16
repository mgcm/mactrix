import Foundation
import MatrixRustSDK
import Models

@Observable
public final class LiveRoom: MatrixRustSDK.Room, Models.Room {
    public var typingUserIds: [String] = []
    public var fetchedMembers: [MatrixRustSDK.RoomMember]? = nil
    public var roomInfo: MatrixRustSDK.RoomInfo? = nil
    
    private var typingHandle: TaskHandle?
    
    public convenience init(sidebarRoom room: SidebarRoom) {
        self.init(unsafeFromRawPointer: room.uniffiClonePointer())
        self.roomInfo = room.roomInfo
    }
    
    public convenience init(matrixRoom room: MatrixRustSDK.Room) {
        self.init(unsafeFromRawPointer: room.uniffiClonePointer())
        loadRoomInfo()
    }
    
    required init(unsafeFromRawPointer pointer: UnsafeMutableRawPointer) {
        super.init(unsafeFromRawPointer: pointer)
        startListening()
    }
    
    fileprivate func startListening() {
        self.typingHandle = subscribeToTypingNotifications(listener: self)
    }
    
    fileprivate func loadRoomInfo() {
        Task {
            do {
                self.roomInfo = try await self.roomInfo()
            } catch {
                print("Failed to load room info: \(error)")
            }
        }
    }
    
    
    public func syncMembers() async throws {
        // guard not already synced
        guard fetchedMembers == nil else { return }
        
        print("syncing members for room: \(self.id)")
        
        let memberIter = try await self.members()
        var result = [MatrixRustSDK.RoomMember]()
        while let memberChunk = memberIter.nextChunk(chunkSize: 1000) {
            result.append(contentsOf: memberChunk)
        }
        fetchedMembers = result
        
        print("synced \(fetchedMembers?.count, default: "(unknown)") members")
    }
    
    public var displayName: String? {
        self.displayName()
    }
    
    public var topic: String? {
        self.topic()
    }
    
    public var encryptionState: Models.EncryptionState {
        self.encryptionState().asModel
    }
}

extension LiveRoom: TypingNotificationsListener {
    public func call(typingUserIds: [String]) {
        self.typingUserIds = typingUserIds
    }
}
