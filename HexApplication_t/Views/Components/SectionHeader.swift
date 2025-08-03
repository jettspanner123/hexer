//
//  SectionHeader.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI
struct SectionHeader: View {
    
    var title: String
    var seeMoreButtonTitle: Bool = false
    
    @EnvironmentObject var applicationStates: ApplicationStates
    
    var body: some View {
        HStack {
            Text(self.title)
                .font(.custom(Fonts.current.pixelRegular, size: 20))
                .foregroundStyle(self.applicationStates.foregroundColor)
            
            Spacer()
            
            if !self.title.isEmpty {
                
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Constants.current.paddingHorizontal + 5)
        .padding(.top, 20)
    }
}

