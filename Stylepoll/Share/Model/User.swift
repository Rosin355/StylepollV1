//
//  User.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 06/10/2020.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Profile: Identifiable {
    
    let id = UUID()
    let uid: String
    let username: String
    let email: String
    let bio: String
    let keywords: [String]
    let avatarImageUrl: String
    @ServerTimestamp var timeStamp: Timestamp?
}

extension Profile: DocumentSerializable {
    
    init?(documentData: [String : Any]) {
        let uid = documentData[SPKeys.Profile.uid] as? String ?? ""
        let username = documentData[SPKeys.Profile.username] as? String ?? ""
        let email = documentData[SPKeys.Profile.email] as? String ?? ""
        let bio = documentData[SPKeys.Profile.bio] as? String ?? ""
        let avatarImageUrl = documentData[SPKeys.Profile.avatarImageUrl] as? String ?? ""
        let keywords = documentData[SPKeys.Profile.keywords] as? [String] ?? [""]
        let timeStamp = documentData[SPKeys.Profile.timeStamp] as? Timestamp ?? Timestamp()
        
        self.init(uid: uid,
                  username: username,
                  email: email,
                  bio: bio,
                  keywords: keywords,
                  avatarImageUrl: avatarImageUrl,
                  timeStamp: timeStamp
                  )
    }
}

protocol DocumentSerializable {
    init?(documentData: [String: Any])
}

struct SPKeys {
    
    struct CollectionPath {
        static let profiles = "users"
    }
    
    struct Profile {
        static let uid = "uid"
        static let username = "username"
        static let email = "email"
        static let bio = "bio"
        static let avatarImageUrl = "avatarImageUrl"
        static let keywords = "keywords"
        static let timeStamp = "timestamp"
        
    }
}
