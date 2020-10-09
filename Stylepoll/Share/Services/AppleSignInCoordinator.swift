//
//
//
//
//

import SwiftUI
import AuthenticationServices

struct AppleSignInCoordinator: UIViewRepresentable {
    var colorScheme: ColorScheme
    @EnvironmentObject var model: SPModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
      
      switch colorScheme {
      case .light:
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.addTarget(context.coordinator, action:  #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
      case .dark:
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
        button.addTarget(context.coordinator, action:  #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
      @unknown default:
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.addTarget(context.coordinator, action:  #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
      }
               
    }

    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
    
    class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
        let parent: AppleSignInCoordinator?
        
        // Unhashed nonce.
        var currentNonce: String?
        
        init(_ parent: AppleSignInCoordinator) {
            self.parent = parent
            super.init()
        }
        
        @objc func didTapButton() {
            #if !targetEnvironment(simulator)
            let nonce = FBAuth.randomNonceString()
            currentNonce = nonce
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            request.nonce = FBAuth.sha256(nonce)
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            #endif
        }
        
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            let vc = UIApplication.shared.windows.last?.rootViewController
            return (vc?.view.window!)!
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            
            guard let parent = parent else {
                fatalError("No parent found")
            }
            
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identity token")
                    return
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                FBAuth.AppleSignIn(providerID: FBAuth.providerID.apple, idTokenString: idTokenString, nonce: nonce) { (result) in
                    switch result {
                    case .success(let authDataResult):
                        let signInWithAppleResult = (authDataResult, appleIDCredential)
                        FBAuth.handle(signInWithAppleResult) { (result) in
                            switch result {
                            case .success(let profile):
                                print("Successfully Signed in with Apple into Firebase: \(profile)")
                            case .failure(let err):
                                print(err.localizedDescription)
                            }
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
                
            } else {
                // error handeling
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            guard let parent = parent else {
                fatalError("No parent found")
            }
        }
    }

}


final class SignInWithAppleButton: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<SignInWithAppleButton>) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: SignInWithAppleButton.UIViewType, context: UIViewRepresentableContext<SignInWithAppleButton>) {
    }
}

