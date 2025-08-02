import Foundation
import SwiftUI


class Constants {
    
    static let current = Constants()
    let paddingHorizontal: CGFloat = 20
   
    let applicationLinearGradient: LinearGradient = .init(gradient: Gradient(colors: [.appPrimary, .black]), startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 1.6))
    let applicationLinearGradientShort: LinearGradient = .init(gradient: Gradient(colors: [.appPrimary, .black]), startPoint: .top, endPoint: .bottom)
    let applicationRedLinearGradient: LinearGradient = .init(gradient: Gradient(colors: [.appLavaLight, .appLava]), startPoint: .top, endPoint: .bottom)
    let applicationThanosLinearGradient: LinearGradient = .init(gradient: Gradient(colors: [.appThanos, .appThanosDark]), startPoint: .top, endPoint: .bottom)
}


