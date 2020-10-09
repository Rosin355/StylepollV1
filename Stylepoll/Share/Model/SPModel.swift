//
//
//
//
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift

enum SPAuthState {
    case undefined, signedOut, signedIn
}


class SPModel: ObservableObject {
    
    @Published var isUserAuthenticated: SPAuthState = .undefined
    @Published var profile: Profile = Profile(uid: "", username: "", email: "", bio: "", keywords: [""], avatarImageUrl: "")
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    // MARK: - Auth
    
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            guard let user = user else {
                print("User is signed out")
                self.isUserAuthenticated = .signedOut
                return
            }
            self.isUserAuthenticated = .signedIn
            print("Successfully authenticated user with uid: \(user.uid)")
            FBFirestore.retreiveProfile(uid: user.uid) { (result) in
                switch result {
                case .success(let profile):
                    print("Retreived: \(profile)")
                    self.profile = profile
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        })
    }
}
