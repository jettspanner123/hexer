//
//  SplashScreen.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

struct SplashScreen: View {
    @EnvironmentObject var applicationStates: ApplicationStates
    @Environment(\.colorScheme) var systemColorScheme
    
    func fetchColor() -> Void {
        Task {
            do {
                let snapshot = try await Firestore.firestore().collection("colors").getDocuments(source: .server)
                
                for document in snapshot.documents {
                    self.applicationStates.fetchedColors.append(try document.data(as: CustomColor.self))
                }
            }
        }
    }
    var body: some View {
        
        VStack {
           Text("H")
                .font(.custom(Fonts.current.pixelBold, size: 100))
                .foregroundStyle(self.applicationStates.backgroundColor)
                .padding(40)
                .background(self.applicationStates.foregroundColor, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(self.applicationStates.backgroundColor)
        .onAppear {
            self.fetchColor()
            
            if self.systemColorScheme == .dark {
                self.applicationStates.colorScheme = .dark
            } else {
                self.applicationStates.colorScheme = .light
            }
        }
    }
}

struct SplashScreen_Preiview: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .environmentObject(ApplicationStates())
    }
}
