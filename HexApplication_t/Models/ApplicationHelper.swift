import Foundation
import SwiftUI

class ApplicationHelper {
    static var current = ApplicationHelper()
    
    func rgbToHex(red: Int, green: Int, blue: Int) -> String {
        return String(format: "%02X%02X%02X", red, green, blue)
    }
    
    
}
