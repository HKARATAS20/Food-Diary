//
//  LoginManager.swift
//  FoodDiary
//
//  Created by Altay Karataş on 5.01.2024.
//

import Foundation
import Firebase

class UserManager: ObservableObject {

    var userLists: [UserList] = []

    func addUser(firstName: String, lastName: String, mail: String, uid: String) {
        let database = Firestore.firestore()
        //        let ref = db.collection("Restaurants").document(name)
        let ref = database.collection("Users").document(uid)
        //        ref.setData(["name": name,"location": location])

        ref.setData(["First Name": firstName, "Last Name": lastName, "mail": mail, "uid": uid]) { (error) in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with auto-generated ID")
            }
        }

    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            // Successfully signed out
        } catch {
            // Handle sign-out error
            print("Error signing out: \(error.localizedDescription)")
        }
    }

}
