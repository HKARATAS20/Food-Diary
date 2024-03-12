//
//  ProfileViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 8.01.2024.
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {

    let user = Auth.auth().currentUser
    var userManager = UserManager()
    @Published var email: String

    init() {
        self.email = user?.email ?? "sample@mail.com"
    }
    func signOut() {
        userManager.signOut()
    }

}
