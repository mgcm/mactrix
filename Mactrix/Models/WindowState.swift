import Foundation

@MainActor
@Observable final class WindowState {
    var selectedScreen: SelectedScreen = .none
}
