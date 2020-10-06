//
//  User.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 06/10/2020.
//

import Foundation

struct User {
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var bio: String
    var keywords: [String]
    
    var dict: [String: Any] {
        return ["uid": uid,
                "email": email,
                "profileImageUrl:": profileImageUrl,
                "username": username,
                "bio": bio,
                "keywords": keywords]
    }
}
