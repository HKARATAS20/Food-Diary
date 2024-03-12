//
//  HomeViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import Foundation
import Firebase

class HomeViewModel: ObservableObject {

    @Published var user = Auth.auth().currentUser
    @Published var email = ""

    func loadUser() {
        if let user = user {
            let uid = user.uid
            let email = user.email
            self.email = user.email!
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
            }

        }
    }
}
