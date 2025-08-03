import Foundation
import SwiftUI

enum ColorScheme: String {
    case light, dark
}

class ApplicationStates: ObservableObject {
    
    @Published var colorScheme: ColorScheme = .light
    @Published var fetchedColors: Array<CustomColor> = []
    var backgroundColor: Color {
        return self.colorScheme == .dark ? .black : .white
    }
    
    var foregroundColor: Color {
        return self.colorScheme == .dark ? .white : .black
    }
    
    func toggleColorScheme() -> Void {
        self.colorScheme = self.colorScheme == .dark ? .light : .dark
    }
    
    @Published var isContextMenuOpen: Bool = false
    
}
