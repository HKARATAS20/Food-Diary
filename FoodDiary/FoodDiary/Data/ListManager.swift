//
//  DataManager.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import Foundation
import Firebase

class ListManager: ObservableObject {
//    @Published var restaurants: [Restaurant] = []
    @Published var userLists: [UserList] = [UserList(
        name: "B", restaurants: [UserListRestaurant(reference: "R", score: "0")])]

    init () {
//        _ = fetchLists()
        print("Bence de basmalı")
    }

    func createList(listName: String, restaurants: [Restaurant]) {
        let database = Firestore.firestore()
        let user = Auth.auth().currentUser
        let ref = database.collection("Users").document(user!.uid) // Ünlem koydum ama koyulmayabilir miydi acaba
        let docref = ref.collection("Lists").document("\(listName)")
        // Burada listeyi oluşturuyor ismiyle
        docref.setData(["Name": "\(listName)"]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added or updated with ID: \(listName)")
            }
        }
        // Burada da Listenin içine collection açıyor restoranlar için (Daha bitmedi bu kısım)
        docref.collection("Restaurants").addDocument(data: ["restaurants": restaurants[0].name]) { error in
            if let error = error {
                print("Error adding collection: \(error)")
            } else {
                print("Collection added or updated with ID: \(restaurants[0].name)")
            }
        }
    }

//    func fetchLists() {
////        var userListsLocal: [UserList] = []
//        //self.userLists.removeAll()
//        let db = Firestore.firestore()
//        let user = Auth.auth().currentUser
//        let userRef = db.collection("Users").document("\(user!.uid)")
//        userRef.collection("Lists").getDocuments { snapshot, error in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//
//            if let snapshot = snapshot {
//                for document in snapshot.documents {
//                    let data = document.data()
//
//                    let id = document.documentID
//                    let name = data["Name"] as? String ?? ""
//
//                    let restaurantRef = userRef.collection("Lists").document(id).collection("Restaurants")
//                    restaurantRef.getDocuments { restaurantSnapshot, restaurantError in
//                        guard restaurantError == nil else {
//                            print(restaurantError!.localizedDescription)
//                            return
//                        }
//
//                        var userListRestaurants: [UserListRestaurant] = []
//
//                        if let restaurantSnapshot = restaurantSnapshot {
//                            for restaurantDocument in restaurantSnapshot.documents {
//                                let restaurantRef = restaurantDocument["Restaurant"] as? String ?? "0"
//                                let restaurantScore = restaurantDocument["score"] as? String ?? "0"
//
//                                let userListRestaurant = 
//                                    UserListRestaurant(reference: restaurantRef, score: restaurantScore)
//                                userListRestaurants.append(userListRestaurant)
//                            }
//                        }
//                        let userList = UserList(name: name, restaurants: userListRestaurants)
//                        print("Buraya girizyoz")
//                        self.userLists.append(userList)
//                    }
//                }
//            }
//        }
//    }

}
