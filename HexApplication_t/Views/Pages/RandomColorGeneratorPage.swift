//
//  RandomColorGeneratorPage.swift
//  HexApplication_t
//
//  Created by Uddeshya Singh on 03/08/25.
//

import SwiftUI
import FirebaseFirestore

struct RandomColorGeneratorPage: View {
    
    @EnvironmentObject var applicationStates: ApplicationStates
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ColorViewModel()
    
    
    @State var redColorProfile: CGFloat = 0
    @State var greenColorProfile: CGFloat = 0
    @State var blueColorProfile: CGFloat = 0
    
    var generatedColor: Color {
        return Color(red: Double(self.redColorProfile) / 255.0,
                     green: Double(self.greenColorProfile) / 255.0,
                     blue: Double(self.blueColorProfile) / 255.0
        )
    }
    
    var hexValue: String {
        return ApplicationHelper.current.rgbToHex(red: Int(self.redColorProfile), green: Int(self.greenColorProfile), blue: Int(self.blueColorProfile))
    }
    
    @State var showTickIcon: Bool = false
    @State var showTickVibrationTrigger: Bool = false
    @State var favouriteButtonDisabled: Bool = false
    
    
    func generateRandomColor() -> Void {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        
        let color = Color(red: Double(red) / 255.0,
                          green: Double(green) / 255.0,
                          blue: Double(blue) / 255.0)
       
        self.redColorProfile = CGFloat(red)
        self.greenColorProfile = CGFloat(green)
        self.blueColorProfile = CGFloat(blue)
    }
    
    func handleCopyToClipboard() -> Void {
        withAnimation {
            self.showTickIcon = true
            self.showTickVibrationTrigger.toggle()
        }
        
        UIPasteboard.general.string = self.hexValue
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.showTickIcon = false
            }
        }
    }
    
    func restorePreviousColor() -> Void {
        withAnimation {
            self.redColorProfile = 0
            self.greenColorProfile = 0
            self.blueColorProfile = 0
        }
    }
    
    @State var favouritesVibration: Bool = false
    @State var showFav: Bool = false
    
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
    
    func addToFavourites() -> Void {
        
        withAnimation {
            self.showFav = true
            self.favouriteButtonDisabled = true
        }
        self.viewModel.colors.append(.init(red: self.redColorProfile, green: self.greenColorProfile, blue: self.blueColorProfile, hex: self.hexValue, timestamp: .now))
        self.viewModel.storage.saveColors(self.viewModel.colors)
        
        if self.viewModel.isOnline {
            self.viewModel.syncToFirebase()
        }
        
        self.favouritesVibration.toggle()
        self.applicationStates.fetchedColors = []
        self.fetchColor()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.showFav = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss()
        }
        
        self.favouriteButtonDisabled = false
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            SecondaryPageHeader(heading: "Color Generator")
                .zIndex(100)
            
            // MARK: Actual scroll view content
            ScrollView(showsIndicators: false) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(self.generatedColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(self.applicationStates.foregroundColor.opacity(0.25))
                    }
                    .applicationHorizontalPadding()
                    .padding(.top, 80)
                
                
                
                // MARK: Hex code profile
                SectionHeader(title: "HEX Code")
                
                HStack {
                    Text("#")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundStyle(self.applicationStates.foregroundColor)
                    
                    Text("\(self.hexValue)")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundStyle(self.applicationStates.foregroundColor)
                        .contentTransition(.numericText(value: Double(self.redColorProfile)))
                        .contentTransition(.numericText(value: Double(self.greenColorProfile)))
                        .contentTransition(.numericText(value: Double(self.blueColorProfile)))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(self.applicationStates.foregroundColor.opacity(0.1))
                }
                .overlay(alignment: .trailing) {
                    if self.showTickIcon {
                        Image(systemName: "checkmark")
                            .foregroundStyle(self.applicationStates.foregroundColor.opacity(0.5))
                            .padding()
                            .transition(.blurReplace)
                    } else {
                        Image(systemName: "document.on.document.fill")
                            .foregroundStyle(self.applicationStates.foregroundColor.opacity(0.5))
                            .padding()
                            .onTapGesture {
                                self.handleCopyToClipboard()
                            }
                            .transition(.blurReplace)
                    }
                }
                .applicationHorizontalPadding()
                
                
                
                // MARK: RGB Color profile
                
                SectionHeader(title: "RGB Profile")
                
                VStack(spacing: 15) {
                   
                    
                    // MARK: Red color profile
                    HStack(spacing: 20) {
                       Circle()
                            .fill(.red.gradient)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Text(String(format: "%.1f", self.redColorProfile))
                                    .font(.system(size: 15, weight: .black, design: .rounded))
                                    .foregroundStyle(.white)
                                    .contentTransition(.numericText(value: Double(self.redColorProfile)))
                            }
                        
                        Slider(value: self.$redColorProfile, in: 0...255)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                   
                    Divider()
                    
                    
                    // MARK: Green color profile
                    HStack(spacing: 20) {
                       Circle()
                            .fill(.green.gradient)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Text(String(format: "%.1f", self.greenColorProfile))
                                    .font(.system(size: 15, weight: .black, design: .rounded))
                                    .foregroundStyle(.white)
                                    .contentTransition(.numericText(value: Double(self.greenColorProfile)))
                            }
                        
                        Slider(value: self.$greenColorProfile, in: 0...255)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Divider()
                    
                    
                    // MARK: Blue color profile
                    HStack(spacing: 20) {
                       Circle()
                            .fill(.blue.gradient)
                            .frame(width: 50, height: 50)
                            .overlay {
                                Text(String(format: "%.1f", self.blueColorProfile))
                                    .font(.system(size: 15, weight: .black, design: .rounded))
                                    .foregroundStyle(.white)
                                    .contentTransition(.numericText(value: Double(self.blueColorProfile)))
                            }
                        
                        Slider(value: self.$blueColorProfile, in: 0...255)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(self.applicationStates.foregroundColor.opacity(0.1))
                }
                .applicationHorizontalPadding()
                
                
                // MARK: Set to defaults button
                
                HStack {
                   Text("Set To Default")
                        .font(.custom(Fonts.current.pixelRegular, size: 18))
                        .foregroundStyle(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.white.gradient, in: RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black.opacity(0.2))
                }
                .applicationHorizontalPadding()
                .padding(.bottom, 100)
                .onTapGesture {
                    self.restorePreviousColor()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            
            
            HStack {
                HStack {
                    if self.showFav {
                        ProgressView()
                            .tint(self.applicationStates.backgroundColor)
                            .transition(.blurReplace)
                    } else {
                        Image(systemName: "heart")
                            .foregroundStyle(self.applicationStates.backgroundColor)
                            .scaleEffect(1.2)
                            .transition(.blurReplace)
                    }
                }
                .frame(width: 60, height: 60)
                .background(self.applicationStates.foregroundColor, in: Circle())
                .onTapGesture {
                    if !self.favouriteButtonDisabled {
                        self.addToFavourites()
                    }
                }
                
                HStack {
                    Text("Generate Color!")
                        .font(.custom(Fonts.current.pixelRegular, size: 20))
                        .foregroundStyle(self.applicationStates.backgroundColor)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(self.applicationStates.foregroundColor, in: Capsule())
                .onTapGesture {
                    withAnimation {
                        self.generateRandomColor()
                    }
                }
                
            }
            .frame(maxWidth: .infinity)
            .applicationHorizontalPadding()
            .background(
                ProgressiveBlur(removeAllFilters: true)
                    .padding(.horizontal, -100)
                    .padding(.bottom, -100)
                    .padding(.top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.1))
                    .blur(radius: 15)
            )
            .offset(y: UIScreen.main.bounds.height - 135)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(self.applicationStates.backgroundColor)
        .navigationBarBackButtonHidden()
        .sensoryFeedback(.increase, trigger: self.redColorProfile)
        .sensoryFeedback(.increase, trigger: self.greenColorProfile)
        .sensoryFeedback(.increase, trigger: self.blueColorProfile)
        .sensoryFeedback(.impact, trigger: self.showTickVibrationTrigger)
        .sensoryFeedback(.impact, trigger: self.favouritesVibration)
        .onChange(of: self.viewModel.isLoading) {
            print("LOADING: ", self.viewModel.isLoading)
        }
        .onAppear {
            self.generateRandomColor()
        }
        
    }
}



struct RandomColorGeneratorPage_Previews: PreviewProvider {
    static var previews: some View {
        RandomColorGeneratorPage()
            .environmentObject(ApplicationStates())
    }
}
