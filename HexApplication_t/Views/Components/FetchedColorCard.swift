
import SwiftUI
import FirebaseFirestore

struct FetchedColorCard: View {
    
    @EnvironmentObject var applicationStates: ApplicationStates
    
    var color: CustomColor
    
    var c_color: Color {
        return Color(red: Double(self.color.red) / 255.0, green: Double(self.color.green) / 255.0, blue: Double(self.color.blue) / 255.0)
    }
    
    @State var showCheckmark: Bool = false
    @State var toggleVibration: Bool = false
    
    func handleCopyToClipboard() -> Void {
        withAnimation {
            self.showCheckmark = true
        }
        self.toggleVibration.toggle()
        
        UIPasteboard.general.string = self.color.hex
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.showCheckmark = false
            }
        }
    }
    
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
    
    @State var isLoading: Bool = false
    
    func handleDelete() -> Void {
        withAnimation {
            self.isLoading = true
        }
        
        Task {
            Firestore.firestore().collection("colors").document(self.color.id).delete()
        }
        
        self.applicationStates.fetchedColors = []
        self.fetchColor()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.isLoading = false
            }
        }
    }
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(self.c_color)
                    .frame(maxHeight: .infinity)
                    .aspectRatio(1/1, contentMode: .fit)
                
                VStack(spacing: 5) {
                    Text("#\(self.color.hex)")
                        .font(.custom(Fonts.current.pixelRegular, size: 20))
                        .foregroundStyle(self.applicationStates.foregroundColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    
                    
                    // MARK: Red channel
                    HStack {
                        Circle()
                            .fill(.red.gradient)
                            .frame(width: 20, height: 20)
                        
                        Text(String(format: "%.1f", self.color.red))
                            .foregroundStyle(self.applicationStates.foregroundColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // MARK: Green channel
                    HStack {
                        Circle()
                            .fill(.blue.gradient)
                            .frame(width: 20, height: 20)
                        
                        Text(String(format: "%.1f", self.color.green))
                            .foregroundStyle(self.applicationStates.foregroundColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // MARK: Blue channel
                    HStack {
                        Circle()
                            .fill(.green.gradient)
                            .frame(width: 20, height: 20)
                        
                        Text(String(format: "%.1f", self.color.blue))
                            .foregroundStyle(self.applicationStates.foregroundColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.vertical, 5)
                
            }
            
            
            // MARK: Delete color button
            HStack {
                if self.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Delete")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 20)
            .padding(10)
            .background(Constants.current.applicationRedLinearGradient, in: RoundedRectangle(cornerRadius: 12))
            .onTapGesture {
                self.handleDelete()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 25))
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(self.applicationStates.foregroundColor.opacity(0.25))
        }
        .overlay(alignment: .topTrailing) {
            if self.showCheckmark {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(self.applicationStates.foregroundColor.opacity(0.25))
                    .padding(25)
            } else {
                Image(systemName: "document.on.document.fill")
                    .resizable()
                    .frame(width: 20, height: 23)
                    .foregroundStyle(self.applicationStates.foregroundColor.opacity(0.25))
                    .padding(25)
            }
            
        }
        .onTapGesture {
            self.handleCopyToClipboard()
        }
        .sensoryFeedback(.impact, trigger: self.toggleVibration)
        .applicationHorizontalPadding()
        .transition(.blurReplace)
    }
}
