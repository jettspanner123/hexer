import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var applicationStates: ApplicationStates
    
    @State var showSplashScreen: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                if self.showSplashScreen {
                    SplashScreen()
                } else {
                    HomePage()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.showSplashScreen = false
                    }
                }
            }
        }
        
    }
    
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApplicationStates())
    }
}
