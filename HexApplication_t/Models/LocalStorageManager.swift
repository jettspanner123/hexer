import Foundation

class LocalStorageManager {
    private let key = "storedColors"
    
    func saveColors(_ colors: Array<CustomColor>) {
        if let data = try? JSONEncoder().encode(colors) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func loadColors() -> [CustomColor] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let colors = try? JSONDecoder().decode([CustomColor].self, from: data) else {
            return []
        }
        return colors
    }
}
