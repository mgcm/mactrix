import SwiftUI
import MatrixRustSDK

struct AccountSettingsView: View {
    @Environment(AppState.self) var appState
    
    @State private var logoutError: String? = nil
    
    var body: some View {
        if let matrixClient = appState.matrixClient {
            Form {
                LabeledContent("User") {
                    Text((try? matrixClient.client.userId()) ?? "error")
                        .textSelection(.enabled)
                }
                
                LabeledContent("Device") {
                    Text((try? matrixClient.client.deviceId()) ?? "error")
                        .textSelection(.enabled)
                }
                
                HStack {
                    Button("Sign out", role: .destructive) {
                        Task {
                            do {
                                try await appState.reset()
                            } catch {
                                logoutError = error.localizedDescription
                            }
                        }
                    }
                    if let logoutError = logoutError {
                        Text(logoutError)
                            .textSelection(.enabled)
                            .foregroundStyle(Color.red)
                    }
                }
            }
        } else {
            ContentUnavailableView("User not logged in", systemImage: "person")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        TabView {
            Tab("Account", systemImage: "person") {
                AccountSettingsView()
            }
            Tab("Appearance", systemImage: "eye") {
                Text("Appearance Settings")
            }
            Tab("Encryption", systemImage: "lock") {
                Text("Encryption Settings")
            }
        }
        .scenePadding()
        .frame(maxWidth: 450, minHeight: 200)
    }
}

#Preview {
    SettingsView()
        .environment(AppState.previewMock)
}
