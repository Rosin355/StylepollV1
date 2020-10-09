//
//  StylepollApp.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 30/09/2020.
//

import SwiftUI
import Firebase

@main
struct StylepollApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var model = SPModel()

    
    var body: some Scene {
        WindowGroup {
            MainNavigation()
                .environmentObject(model)
        }
    }
}

// MARK: - AppDelegate
class AppDelegate: NSCoder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously()
        }
        return true
    }
}
