//
//  HexApplication_tApp.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 02/08/25.
//

import SwiftUI
import SwiftData

@main
struct HexApplication_tApp: App {
    
    @StateObject var applicationStates: ApplicationStates = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(self.applicationStates)
    }
}
