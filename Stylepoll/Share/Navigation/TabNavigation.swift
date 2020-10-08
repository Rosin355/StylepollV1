//
//
//


import SwiftUI

struct TabNavigation: View {
    
    @State private var selection: Tab = .menu

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                MainView()
            }
            .tabItem {
                Label("Explore", systemImage: "magnifyingglass")
                    .accessibility(label: Text("Explore"))
            }
            .tag(Tab.menu)
            
            NavigationView {
                Text("Explore")
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
                    .accessibility(label: Text("Favorites"))
            }
            .tag(Tab.favorites)
            
            NavigationView {
                Text("Explore")
            }
            .tabItem {
                Label("Trips", systemImage: "globe")
                    .accessibility(label: Text("Trips"))
            }
            .tag(Tab.trips)
            
            NavigationView {
                AccountView()
            }
            .tabItem {
                Label("Account", systemImage: "person")
                    .accessibility(label: Text("Account"))
            }
            .tag(Tab.recipes)
        }
    }
}

// MARK: - Tab

extension TabNavigation {
    enum Tab {
        case menu
        case favorites
        case trips
        case recipes
    }
}

// MARK: - Previews

struct TabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigation()
    }
}
