//
//  LoginViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 30.12.2023.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var userName = ""
    @Published var registerTitle = "Don't have an account? Register"
    @Published var loginTitle = "Already have an account? Log In"
    @Published var userIsLoggedIn = false
    @Published var userManager = UserManager()
    @Published var registerShown = false
    @Published var errorMessage = ""

    func registerAction() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error !=  nil {
                print(error!.localizedDescription)
                self.errorMessage = error!.localizedDescription
            } else {
                self.userManager.addUser(firstName: self.firstName,
                                         lastName: self.lastName,
                                         mail: self.email,
                                         uid: (result?.user.uid)!)
                print(result.debugDescription)
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.userName
                changeRequest?.commitChanges { _ in

                }
            }
        }
    }

    func loginAction() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if error !=  nil {
                print("login action terörü")
                print(error!.localizedDescription)
                self.errorMessage = error!.localizedDescription
            }

        }
    }

}
