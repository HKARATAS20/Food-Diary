//
//  FoodDiaryApp.swift
//  FoodDiary
//
//  Created by Altay Karataş on 20.12.2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

class UserLoggedIn: ObservableObject {
    @Published var userLoggedIn = false
}

@main
struct YourApp: App {
  // register app delegate for Firebase setup

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var dataManager = DataManager()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(dataManager)
            }
        }
    }
}
