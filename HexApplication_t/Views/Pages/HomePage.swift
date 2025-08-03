//
//  HomePage.swift
//  HexApplication
//
//  Created by Uddeshya Singh on 02/08/25.
//

import SwiftUI

struct HomePage: View {
    
    
    @EnvironmentObject var applicationStates: ApplicationStates
    @StateObject var manager = ColorViewModel()
    var screenDimentions = UIScreen.main.bounds
    
    var temp: CustomColor = .init(red: 22, green: 32, blue: 123, hex: "#123123", timestamp: .now)
    
    var darkModeIcon: some View {
        
        HStack {
            if self.applicationStates.colorScheme == .light {
                Image(systemName: "moon.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(self.applicationStates.backgroundColor)
                    .transition(.blurReplace)
            } else {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(self.applicationStates.backgroundColor)
                    .transition(.blurReplace)
            }
        }
        .frame(width: 45, height: 45)
        .background(self.applicationStates.foregroundColor, in: Circle())
        .onTapGesture {
            withAnimation {
                self.applicationStates.toggleColorScheme()
            }
        }
        
    }
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // MARK: This is the top bar
            HStack {
                Image(systemName: "distribute.vertical")
                    .foregroundStyle(self.applicationStates.foregroundColor)
                
                
                Text("Hexer".uppercased())
                    .font(.custom(Fonts.current.pixelBold, size: 35))
                    .foregroundStyle(self.applicationStates.foregroundColor)
                
                Spacer()
                
                HStack {
                    
                    Image(systemName: self.manager.isOnline ? "network" : "network.slash")
                        .foregroundStyle(self.applicationStates.foregroundColor)
                    
                    Text(self.manager.isOnline ? "Online" : "Offline")
                        .foregroundStyle(self.applicationStates.foregroundColor)
                }
                .frame(height: 45)
                .padding(.horizontal)
                .background(.gray.opacity(0.1), in: Capsule())
                .overlay {
                    Capsule()
                        .stroke(self.applicationStates.foregroundColor.opacity(0.25))
                }
                
                self.darkModeIcon
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .applicationHorizontalPadding()
            .padding(.top, 100)
            .background(
                ProgressiveBlur(removeAllFilters: true)
                    .padding(.horizontal, -100)
                    .padding(.top, -20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.1))
                    .blur(radius: 15)
            )
            .offset(y: -90)
            .zIndex(11)
            
            
            
            
            
            
            
            // MARK: This is the scroll View
            ScrollView(showsIndicators: false) {
                
                NavigationLink(destination: RandomColorGeneratorPage()) {
                    QuickActionButton(text: "Random Colour Generator")
                        .background(Constants.current.applicationThanosLinearGradient, in: RoundedRectangle(cornerRadius: 18))
                        .padding(.top, 80)
                        .applicationHorizontalPadding()
                }
//                
//                HStack {
//                    NavigationLink(destination: ColorPalletGenerator()) {
//                        QuickActionButton(text: "Colour Pallet")
//                        .background(Constants.current.applicationThanosLinearGradient, in: RoundedRectangle(cornerRadius: 18))
//                    }
//                    QuickActionButton(text: "AI Colour")
//                        .background(Constants.current.applicationRedLinearGradient, in: RoundedRectangle(cornerRadius: 18))
//                }
//                .frame(maxWidth: .infinity)
//                .applicationHorizontalPadding()
                
                
                
                
                // MARK: Previous generated colors
                SectionHeader(title: "Previous Generated Colours")
                
                
                // MARK: Fallback for no items
                if self.applicationStates.fetchedColors.isEmpty {
                    Image(systemName: "tray.fill")
                        .resizable()
                        .frame(width: 110, height: 90)
                        .foregroundStyle(self.applicationStates.foregroundColor.opacity(0.2))
                        .padding(.top, 35)
                    Text("No Colours Yet")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundStyle(self.applicationStates.foregroundColor.opacity(0.2))
                }
                
                ForEach(self.applicationStates.fetchedColors, id: \.id) { color in
                    FetchedColorCard(color: color)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(self.applicationStates.backgroundColor)
    }
}



