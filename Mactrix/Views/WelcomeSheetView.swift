import SwiftUI
import MatrixRustSDK

struct WelcomeSheetView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    
    @State private var homeserverField: String = ""
    @State private var usernameField: String = ""
    @State private var passwordField: String = ""
    
    @State private var loading: Bool = false
    @State private var showError: Error? = nil
    
    func signIn() {
        Task {
            loading = true
            
            do {
                let client = try await MatrixClient.login(homeServer: homeserverField, username: usernameField, password: passwordField)
                appState.matrixClient = client
            } catch {
                showError = error
            }
            
            loading = false
            dismiss()
        }
    }
    
    var body: some View {
        VStack {
            Text("Welcome to Mactrix")
                .font(.headline)
                .padding(.bottom)
            
            Form {
                TextField("Homeserver", text: $homeserverField)
                    .disabled(loading)
                    .onSubmit { signIn() }
                TextField("Username", text: $usernameField)
                    .disabled(loading)
                    .onSubmit { signIn() }
                SecureField("Password", text: $passwordField)
                    .disabled(loading)
                    .onSubmit { signIn() }
                
                HStack {
                    Button("Sign in") { signIn() }
                    .disabled(loading)
                    Button("Register account") {}
                        .buttonStyle(.link)
                        .disabled(loading)
                    ProgressView()
                        .scaleEffect(0.5)
                        .opacity(loading ? 1 : 0)
                }
            }
            .frame(maxWidth: 300)
            
            if let showError = showError {
                Text(showError.localizedDescription)
                    .foregroundStyle(Color.red)
                    .textSelection(.enabled)
            }
            
        }
        .padding()
    }
    
    
}

#Preview {
    WelcomeSheetView()
        .environment(AppState())
}
