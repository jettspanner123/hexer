import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var applicationStates: ApplicationStates
    
    var body: some View {
        NavigationStack {
            ZStack {
                HomePage()
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
