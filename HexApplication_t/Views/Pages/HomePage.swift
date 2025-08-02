//
//  HomePage.swift
//  HexApplication
//
//  Created by Uddeshya Singh on 02/08/25.
//

import SwiftUI

struct HomePage: View {
    
    
    @EnvironmentObject var applicationStates: ApplicationStates
    var screenDimentions = UIScreen.main.bounds
    
    
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
            .offset(y: -100)
            .zIndex(11)
            
            
            
            
            
            
            
            // MARK: This is the scroll View
            ScrollView(showsIndicators: false) {
                
                NavigationLink(destination: RandomColorGeneratorPage()) {
                    if self.applicationStates.colorScheme == .light {
                        QuickActionButton(text: "Random Color Generator")
                            .background(Constants.current.applicationLinearGradient, in: RoundedRectangle(cornerRadius: 18))
                            .padding(.top, 75)
                            .applicationHorizontalPadding()
                    } else {
                        QuickActionButton(text: "Random Color Generator")
                            .background(.appPrimary, in: RoundedRectangle(cornerRadius: 18))
                            .padding(.top, 75)
                            .applicationHorizontalPadding()
                    }
                }
                
                HStack {
                    QuickActionButton(text: "Color Pallet")
                        .background(Constants.current.applicationThanosLinearGradient, in: RoundedRectangle(cornerRadius: 18))
                    QuickActionButton(text: "Favourites")
                        .background(Constants.current.applicationRedLinearGradient, in: RoundedRectangle(cornerRadius: 18))
                }
                .frame(maxWidth: .infinity)
                .applicationHorizontalPadding()
                
                SectionHeader(title: "Previous Generated Button")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(self.applicationStates.backgroundColor)
    }
}

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
