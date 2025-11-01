import Foundation
import MatrixRustSDK

class MatrixClientMock: ClientProtocol {
    
    struct MockError: Error {}
    
    func abortOidcAuth(authorizationData: MatrixRustSDK.OAuthAuthorizationData) async {
        
    }
    
    func accountData(eventType: String) async throws -> String? {
        return nil
    }
    
    func accountUrl(action: MatrixRustSDK.AccountManagementAction?) async throws -> String? {
        return nil
    }
    
    func addRecentEmoji(emoji: String) async throws {
        
    }
    
    func availableSlidingSyncVersions() async -> [MatrixRustSDK.SlidingSyncVersion] {
        return []
    }
    
    func avatarUrl() async throws -> String? {
        return nil
    }
    
    func awaitRoomRemoteEcho(roomId: String) async throws -> MatrixRustSDK.Room {
        throw MockError()
    }
    
    func cachedAvatarUrl() async throws -> String? {
        return nil
    }
    
    func canDeactivateAccount() -> Bool {
        return false
    }
    
    func clearCaches(syncService: MatrixRustSDK.SyncService?) async throws {
        
    }
    
    func createRoom(request: MatrixRustSDK.CreateRoomParameters) async throws -> String {
        throw MockError()
    }
    
    func customLoginWithJwt(jwt: String, initialDeviceName: String?, deviceId: String?) async throws {
        throw MockError()
    }
    
    func deactivateAccount(authData: MatrixRustSDK.AuthData?, eraseData: Bool) async throws {
        throw MockError()
    }
    
    func deletePusher(identifiers: MatrixRustSDK.PusherIdentifiers) async throws {
        throw MockError()
    }
    
    func deviceId() throws -> String {
        return "DEVICE_ID"
    }
    
    func displayName() async throws -> String {
        return "John Doe"
    }
    
    func enableAllSendQueues(enable: Bool) async {
        
    }
    
    func enableSendQueueUploadProgress(enable: Bool) {
        
    }
    
    func encryption() -> MatrixRustSDK.Encryption {
        return Encryption(noPointer: .init())
    }
    
    func fetchMediaPreviewConfig() async throws -> MatrixRustSDK.MediaPreviewConfig? {
        return nil
    }
    
    func getDmRoom(userId: String) throws -> MatrixRustSDK.Room? {
        return nil
    }
    
    func getInviteAvatarsDisplayPolicy() async throws -> MatrixRustSDK.InviteAvatars? {
        return nil
    }
    
    func getMaxMediaUploadSize() async throws -> UInt64 {
        return 1000
    }
    
    func getMediaContent(mediaSource: MatrixRustSDK.MediaSource) async throws -> Data {
        throw MockError()
    }
    
    func getMediaFile(mediaSource: MatrixRustSDK.MediaSource, filename: String?, mimeType: String, useCache: Bool, tempDir: String?) async throws -> MatrixRustSDK.MediaFileHandle {
        throw MockError()
    }
    
    func getMediaPreviewDisplayPolicy() async throws -> MatrixRustSDK.MediaPreviews? {
        return nil
    }
    
    func getMediaThumbnail(mediaSource: MatrixRustSDK.MediaSource, width: UInt64, height: UInt64) async throws -> Data {
        throw MockError()
    }
    
    func getNotificationSettings() async -> MatrixRustSDK.NotificationSettings {
        return NotificationSettings(noPointer: .init())
    }
    
    func getProfile(userId: String) async throws -> MatrixRustSDK.UserProfile {
        throw MockError()
    }
    
    func getRecentEmojis() async throws -> [MatrixRustSDK.RecentEmoji] {
        throw MockError()
    }
    
    func getRecentlyVisitedRooms() async throws -> [String] {
        return []
    }
    
    func getRoom(roomId: String) throws -> MatrixRustSDK.Room? {
        return nil
    }
    
    func getRoomPreviewFromRoomAlias(roomAlias: String) async throws -> MatrixRustSDK.RoomPreview {
        throw MockError()
    }
    
    func getRoomPreviewFromRoomId(roomId: String, viaServers: [String]) async throws -> MatrixRustSDK.RoomPreview {
        throw MockError()
    }
    
    func getSessionVerificationController() async throws -> MatrixRustSDK.SessionVerificationController {
        throw MockError()
    }
    
    func getUrl(url: String) async throws -> Data {
        throw MockError()
    }
    
    func homeserver() -> String {
        return "homeserver.local"
    }
    
    func homeserverLoginDetails() async -> MatrixRustSDK.HomeserverLoginDetails {
        return HomeserverLoginDetails(noPointer: .init())
    }
    
    func ignoreUser(userId: String) async throws {
        throw MockError()
    }
    
    func ignoredUsers() async throws -> [String] {
        throw MockError()
    }
    
    func isLivekitRtcSupported() async throws -> Bool {
        return false
    }
    
    func isReportRoomApiSupported() async throws -> Bool {
        return false
    }
    
    func isRoomAliasAvailable(alias: String) async throws -> Bool {
        return false
    }
    
    func joinRoomById(roomId: String) async throws -> MatrixRustSDK.Room {
        throw MockError()
    }
    
    func joinRoomByIdOrAlias(roomIdOrAlias: String, serverNames: [String]) async throws -> MatrixRustSDK.Room {
        throw MockError()
    }
    
    func knock(roomIdOrAlias: String, reason: String?, serverNames: [String]) async throws -> MatrixRustSDK.Room {
        throw MockError()
    }
    
    func login(username: String, password: String, initialDeviceName: String?, deviceId: String?) async throws {
        throw MockError()
    }
    
    func loginWithEmail(email: String, password: String, initialDeviceName: String?, deviceId: String?) async throws {
        throw MockError()
    }
    
    func loginWithOidcCallback(callbackUrl: String) async throws {
        throw MockError()
    }
    
    func loginWithQrCode(oidcConfiguration: MatrixRustSDK.OidcConfiguration) -> MatrixRustSDK.LoginWithQrCodeHandler {
        return LoginWithQrCodeHandler(noPointer: .init())
    }
    
    func logout() async throws {
        throw MockError()
    }
    
    func notificationClient(processSetup: MatrixRustSDK.NotificationProcessSetup) async throws -> MatrixRustSDK.NotificationClient {
        throw MockError()
    }
    
    func observeAccountDataEvent(eventType: MatrixRustSDK.AccountDataEventType, listener: any MatrixRustSDK.AccountDataListener) -> MatrixRustSDK.TaskHandle {
        return TaskHandle(noPointer: .init())
    }
    
    func observeRoomAccountDataEvent(roomId: String, eventType: MatrixRustSDK.RoomAccountDataEventType, listener: any MatrixRustSDK.RoomAccountDataListener) throws -> MatrixRustSDK.TaskHandle {
        throw MockError()
    }
    
    func removeAvatar() async throws {
        throw MockError()
    }
    
    func resetServerInfo() async throws {
        throw MockError()
    }
    
    func resolveRoomAlias(roomAlias: String) async throws -> MatrixRustSDK.ResolvedRoomAlias? {
        throw MockError()
    }
    
    func restoreSession(session: MatrixRustSDK.Session) async throws {
        throw MockError()
    }
    
    func restoreSessionWith(session: MatrixRustSDK.Session, roomLoadSettings: MatrixRustSDK.RoomLoadSettings) async throws {
        throw MockError()
    }
    
    func roomAliasExists(roomAlias: String) async throws -> Bool {
        throw MockError()
    }
    
    func roomDirectorySearch() -> MatrixRustSDK.RoomDirectorySearch {
        return RoomDirectorySearch(noPointer: .init())
    }
    
    func rooms() -> [MatrixRustSDK.Room] {
        return []
    }
    
    func searchUsers(searchTerm: String, limit: UInt64) async throws -> MatrixRustSDK.SearchUsersResults {
        throw MockError()
    }
    
    func server() -> String? {
        return "SERVER"
    }
    
    func serverVendorInfo() async throws -> MatrixRustSDK.ServerVendorInfo {
        throw MockError()
    }
    
    func session() throws -> MatrixRustSDK.Session {
        return Session(accessToken: "ACCESS_TOKEN", refreshToken: "REFRESH_TOKEN", userId: "USER_ID", deviceId: "DEVICE_ID", homeserverUrl: "HOMESERVER_URL", oidcData: nil, slidingSyncVersion: .none)
    }
    
    func setAccountData(eventType: String, content: String) async throws {
        throw MockError()
    }
    
    func setDelegate(delegate: (any MatrixRustSDK.ClientDelegate)?) throws -> MatrixRustSDK.TaskHandle? {
        throw MockError()
    }
    
    func setDisplayName(name: String) async throws {
        throw MockError()
    }
    
    func setInviteAvatarsDisplayPolicy(policy: MatrixRustSDK.InviteAvatars) async throws {
        throw MockError()
    }
    
    func setMediaPreviewDisplayPolicy(policy: MatrixRustSDK.MediaPreviews) async throws {
        throw MockError()
    }
    
    func setMediaRetentionPolicy(policy: MatrixRustSDK.MediaRetentionPolicy) async throws {
        throw MockError()
    }
    
    func setPusher(identifiers: MatrixRustSDK.PusherIdentifiers, kind: MatrixRustSDK.PusherKind, appDisplayName: String, deviceDisplayName: String, profileTag: String?, lang: String) async throws {
        throw MockError()
    }
    
    func setUtdDelegate(utdDelegate: any MatrixRustSDK.UnableToDecryptDelegate) async throws {
        throw MockError()
    }
    
    func slidingSyncVersion() -> MatrixRustSDK.SlidingSyncVersion {
        return .none
    }
    
    func spaceService() -> MatrixRustSDK.SpaceService {
        return SpaceService(noPointer: .init())
    }
    
    func startSsoLogin(redirectUrl: String, idpId: String?) async throws -> MatrixRustSDK.SsoHandler {
        throw MockError()
    }
    
    func subscribeToIgnoredUsers(listener: any MatrixRustSDK.IgnoredUsersListener) -> MatrixRustSDK.TaskHandle {
        return TaskHandle(noPointer: .init())
    }
    
    func subscribeToMediaPreviewConfig(listener: any MatrixRustSDK.MediaPreviewConfigListener) async throws -> MatrixRustSDK.TaskHandle {
        throw MockError()
    }
    
    func subscribeToRoomInfo(roomId: String, listener: any MatrixRustSDK.RoomInfoListener) async throws -> MatrixRustSDK.TaskHandle {
        throw MockError()
    }
    
    func subscribeToSendQueueStatus(listener: any MatrixRustSDK.SendQueueRoomErrorListener) -> MatrixRustSDK.TaskHandle {
        return TaskHandle(noPointer: .init())
    }
    
    func subscribeToSendQueueUpdates(listener: any MatrixRustSDK.SendQueueRoomUpdateListener) async throws -> MatrixRustSDK.TaskHandle {
        throw MockError()
    }
    
    func syncService() -> MatrixRustSDK.SyncServiceBuilder {
        return SyncServiceBuilder(noPointer: .init())
    }
    
    func trackRecentlyVisitedRoom(room: String) async throws {
        throw MockError()
    }
    
    func unignoreUser(userId: String) async throws {
        throw MockError()
    }
    
    func uploadAvatar(mimeType: String, data: Data) async throws {
        throw MockError()
    }
    
    func uploadMedia(mimeType: String, data: Data, progressWatcher: (any MatrixRustSDK.ProgressWatcher)?) async throws -> String {
        throw MockError()
    }
    
    func urlForOidc(oidcConfiguration: MatrixRustSDK.OidcConfiguration, prompt: MatrixRustSDK.OidcPrompt?, loginHint: String?, deviceId: String?, additionalScopes: [String]?) async throws -> MatrixRustSDK.OAuthAuthorizationData {
        throw MockError()
    }
    
    func userId() throws -> String {
        return "USER_ID"
    }
    
    func userIdServerName() throws -> String {
        return "USER_ID_SERVER_NAME"
    }
    
        
}
