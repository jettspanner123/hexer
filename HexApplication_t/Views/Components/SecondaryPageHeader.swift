//
//  SecondaryPageHeader.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI


struct SecondaryPageHeader: View {
    var heading: String
    
    @EnvironmentObject var applicationStates: ApplicationStates
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
           Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10, height: 20)
                .foregroundStyle(self.applicationStates.backgroundColor)
                .offset(x: -1)
                .frame(width: 45, height: 45)
                .background(self.applicationStates.foregroundColor, in: Circle())
                .padding()
                .onTapGesture {
                    self.dismiss()
                }
            
            Spacer()
            
            Text(self.heading)
                .font(.custom(Fonts.current.pixelBold, size: 25))
                .foregroundStyle(self.applicationStates.foregroundColor)
            
            Spacer()
            
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10, height: 20)
                .foregroundStyle(self.applicationStates.backgroundColor)
                .offset(x: -1)
                .frame(width: 40, height: 40)
                .background(self.applicationStates.foregroundColor, in: Circle())
                .padding()
                .onTapGesture {
                    self.dismiss()
                }
                .hidden()
        }
        .frame(maxWidth: .infinity)
        .background(
            ProgressiveBlur(removeAllFilters: true)
                .padding(.horizontal, -100)
                .padding(.top, -120)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black.opacity(0.1))
                .blur(radius: 15)
        )
        .offset(y: -15)
    }
}
