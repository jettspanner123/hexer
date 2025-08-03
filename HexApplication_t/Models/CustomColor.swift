import Foundation

struct CustomColor: Identifiable, Codable {
    var id: String = UUID().uuidString
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var hex: String
    var timestamp: Date
    var isSynced: Bool = false
}
