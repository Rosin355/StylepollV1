//
//
//
//
//

import SwiftUI
import FirebaseAuth
import CryptoKit
import AuthenticationServices
import FirebaseFirestore


typealias SignInWithAppleResult = (authDataResult: AuthDataResult, appleIDCredential: ASAuthorizationAppleIDCredential)

enum AuthState {
    case undefined, signedOut, signedIn
}

struct FBAuth {
    
    struct providerID {
        static let apple = "apple.com"
    }
    
    static func logout(completion: @escaping (Result<Bool, Error>) -> ()) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completion(.success(true))
        } catch let err {
            completion(.failure(err))
        }
    }
    
    static func AppleSignIn(providerID: String,
                            idTokenString: String,
                            nonce: String,
                            completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
        // Initialize a Firebase credential.
        let credential = OAuthProvider.credential(withProviderID: providerID,
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        
        
        // link credetial to firabase
        Auth.auth().currentUser?.link(with: credential, completion: { (authDataResult, error) in
            if let error = error, (error as NSError).code == AuthErrorCode.credentialAlreadyInUse.rawValue {
                print("The user you're trying to sign in with has already been linked")
                if let updatedCredential = (error as NSError).userInfo[AuthErrorUserInfoUpdatedCredentialKey] as? AuthCredential {
                    print("Signing in using the updated credentials")
                    
                    // Sign in with Firebase.
                    Auth.auth().signIn(with: updatedCredential) { (authDataResult, err) in
                        if let err = err {
                            // Error. If error.code == .MissingOrInvalidNonce, make sure
                            // you're sending the SHA256-hashed nonce as a hex string with
                            // your request to Apple.
                            print(err.localizedDescription)
                            completion(.failure(err))
                            return
                        }
                        // User is signed in to Firebase with Apple.
                        guard let authDataResult = authDataResult else {
                            completion(.failure(SignInWithAppleAuthError.noAuthDataResult))
                            return
                        }
                        completion(.success(authDataResult))
                    }
                    
                }
            }
            // User is signed in to Firebase with Apple.
            guard let authDataResult = authDataResult else {
                completion(.failure(SignInWithAppleAuthError.noAuthDataResult))
                return
            }
            completion(.success(authDataResult))
            
        })
        
       
    }
    
    static func handle(_ signInWithAppleResult: SignInWithAppleResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        let uid = signInWithAppleResult.authDataResult.user.uid
        
        var name = ""
        let fullName = signInWithAppleResult.appleIDCredential.fullName
        let givenName = fullName?.givenName ?? ""
        let middleName = fullName?.middleName ?? ""
        let familyName = fullName?.familyName ?? ""
        let names = [givenName, middleName, familyName]
        let filteredNames = names.filter {$0 != ""}
        for i in 0..<filteredNames.count {
            name += filteredNames[i]
            if i != filteredNames.count - 1 {
                name += " "
            }
        }
        
        let email = signInWithAppleResult.authDataResult.user.email ?? ""
        
        var data: [String: Any]
        
        if name != "" {
            data = [
                SPKeys.Profile.uid: uid,
                SPKeys.Profile.username: name,
                SPKeys.Profile.email: email,
                SPKeys.Profile.bio: "",
                SPKeys.Profile.keywords: [""],
                SPKeys.Profile.timeStamp: Timestamp()
            ]
        } else {
            data = [
                SPKeys.Profile.uid: uid,
                SPKeys.Profile.username: name,
                SPKeys.Profile.email: email,
                SPKeys.Profile.bio: "",
                SPKeys.Profile.keywords: [""],
                SPKeys.Profile.timeStamp: Timestamp()
            ]
        }
        
        FBFirestore.mergeProfile(data, uid: uid) { (result) in
            completion(result)
        }
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    @available(iOS 13, *)
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        return hashString
    }
}


