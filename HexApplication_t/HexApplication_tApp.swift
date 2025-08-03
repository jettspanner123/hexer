//
//  HexApplication_tApp.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 02/08/25.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct HexApplication_tApp: App {
    
    @StateObject var applicationStates: ApplicationStates = .init()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(self.applicationStates)
    }
}
