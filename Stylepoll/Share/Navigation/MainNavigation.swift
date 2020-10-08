//
//
//
//
//

import SwiftUI

struct MainNavigation: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    @ViewBuilder var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
           TabNavigation()
        } else {
           SidebarNavigation()
        }
        #else
        SidebarNavigation()
            .frame(minWidth: 900, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
        #endif
    }
}

struct MainNavigation_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigation()
    }
}

