//
//  SignUpView.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 01/10/2020.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

struct SignUpView: View {
    
    // MARK: - PROPERTIES
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var showImagePicker: Bool = false
    @State var image: Image = Image(IMAGE_USER_PLACEHOLDER)
    @State var imageData: Data = Data()
    
    //FIREBASE AUTH CONFIG
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                return
            }
            
            guard let userId = authData?.user.uid else { return }
            
            // check the root from the storage console on Firebase
            let storageRoot = Storage.storage().reference(forURL: "gs://stylepollv1.appspot.com")
            
            let storageAvatar = storageRoot.child("avatar")
            let storageAvatarUserId = storageAvatar.child(userId)
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            storageAvatarUserId.putData(self.imageData, metadata: metaData) { (storageMetadata, error) in
                
                if error != nil {
                    return
                }
                
                storageAvatarUserId.downloadURL { (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                            changeRequest.photoURL = url
                            changeRequest.displayName = self.username
                            changeRequest.commitChanges { (error) in
                                if error != nil {
                                    return
                                }
                            }
                        }
                        
                        let firestoreRoot = Firestore.firestore()
                        let firestoreUsers = firestoreRoot.collection("users")
                        let firestoreUserId = firestoreUsers.document(userId)
                        let userInfo = ["username": self.username, "email": self.email, "profileImageUrl": metaImageUrl]
                        let user = User.init(uid: userId, email: self.email, profileImageUrl: metaImageUrl, username: self.username, bio: "", keywords: [])
                        
                        firestoreUserId.setData(userInfo)
                        
                    }
                }
            }
        }
    }
    
    
    // MARK: - BODY
    var body: some View {
        VStack{
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.bottom, 50)
                .onTapGesture {
                    print("Tapped")
                    self.showImagePicker = true
                }
            
            UsernameTextField(username: $username)
            EmailTextField(email: $email)

            VStack(alignment: .leading){
                PasswordTextField(password: $password)
                Text(TEXT_PASSWORD_REQUIRED)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.leading)
            }
            SignupButton(action: {
                signUp()
            }, label: TEXT_SIGN_UP)
            Divider()
            Text(TEXT_SIGNUP_NOTE)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding()
                
        }
        .sheet(isPresented: $showImagePicker){
            ImagePicker(showImagePicker: self.$showImagePicker, pickedImage: self.$image, imageData: self.$imageData)
        }
        .navigationBarTitle("Register",displayMode: .inline)
    }
}

// MARK: - PROPERTIES
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
