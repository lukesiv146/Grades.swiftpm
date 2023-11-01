import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LukeView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Luke")
                }
            
            AdrianGrades()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Adrian")
                }
        }
    }
}
