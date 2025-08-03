import SwiftUI

struct ColorPalletGenerator: View {
    
    @EnvironmentObject var applicationStates: ApplicationStates
    
    @State var generatedColor: Color = .white
    
    func generateRandomColor() -> Void {
        
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
           SecondaryPageHeader(heading: "Colour Pallet")
                .zIndex(100)
            
            ScrollView {
               SectionHeader(title: "Choose A Colour")
                    .padding(.top, 65)
                
                
                HStack {
                   Circle()
                        .frame(width: 80)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 25))
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(self.applicationStates.foregroundColor.opacity(0.1))
                }
                .applicationHorizontalPadding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(self.applicationStates.backgroundColor)
        .navigationBarBackButtonHidden()
    }
}

struct ColorPalletGenerator_Previews: PreviewProvider {
    static var previews: some View {
        ColorPalletGenerator()
            .environmentObject(ApplicationStates())
    }
}
