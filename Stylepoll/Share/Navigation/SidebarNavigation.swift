//
//
//
//
//

import SwiftUI

struct SidebarNavigation: View {
    enum NavigationItem {
        case menu
        case favorites
        case recipes
    }

//    @EnvironmentObject private var model: CoffeShopModel
    @State private var selection: Set<NavigationItem> = [.menu]
    @State private var presentingRewards = false
    
    var sidebar: some View {
        List(selection: $selection) {
            NavigationLink(destination:  Text("Explore") ) {
                Label("Explore", systemImage: "magnifyingglass")
            }
            .accessibility(label: Text("Explore"))
            .tag(NavigationItem.menu)
            
            NavigationLink(destination: Text("hello")) {
                Label("Favorites", systemImage: "heart")
            }
            .accessibility(label: Text("Favorites"))
            .tag(NavigationItem.favorites)
        
            NavigationLink(destination: Text("hello")) {
                Label("Trips", systemImage: "globe")
            }
            .accessibility(label: Text("Trips"))
            .tag(NavigationItem.recipes)
        }
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            sidebar.frame(minWidth: 100, idealWidth: 150, maxWidth: 200, maxHeight: .infinity)
            #else
            sidebar
            #endif
            MainView()
           
        }
    }
    
}

struct SidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        SidebarNavigation()
//            .environmentObject(CoffeShopModel())
    }
}

