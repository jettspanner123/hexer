//
//  RandomColorGeneratorPage.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI

struct RandomColorGeneratorPage: View {
    
    @EnvironmentObject var applicationStates: ApplicationStates
    var body: some View {
        ZStack(alignment: .topLeading) {
            SecondaryPageHeader(heading: "Color Generator")
                .zIndex(100)
            
            // MARK: Actual scroll view content
            ScrollView {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .applicationHorizontalPadding()
                    .padding(.top, 80)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(self.applicationStates.backgroundColor)
        .navigationBarBackButtonHidden()
    }
}



struct RandomColorGeneratorPage_Previews: PreviewProvider {
    static var previews: some View {
        RandomColorGeneratorPage()
            .environmentObject(ApplicationStates())
    }
}
