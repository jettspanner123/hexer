import Foundation
import SwiftUI

class ColorViewModel: ObservableObject {
    @Published var colors: [CustomColor] = []
    @Published var isOnline = true
    @Published var isLoading: Bool = false
    
    let storage = LocalStorageManager()
    let firebase = FirebaseManager()
    var monitor = NetworkMonitor()
    
    init() {
        self.colors = storage.loadColors()
        monitor.$isConnected.assign(to: &$isOnline)
        
        if isOnline {
            syncToFirebase()
        }
    }
    
    func syncToFirebase() {
        withAnimation {
            self.isLoading = true
        }
        firebase.syncColors(colors) {
            self.colors = self.colors.map {
                var updated = $0
                updated.isSynced = true
                return updated
            }
            self.storage.saveColors(self.colors)
        }
        
        withAnimation {
            self.isLoading = false
        }
    }
}
