//
//  DataManager.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import Foundation
import Firebase

class DataManager: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var userLists: [UserList] = []
    @Published var listRestaurants: [Restaurant] = []

    init() {
        fetchRestaurants()
//        fetchLists()
//   print("Restaoranlar \(restaurants[0].name)")
    }

    func fetchRestaurants() {
        restaurants.removeAll()
        let database = Firestore.firestore()
        let ref = database.collection("Restaurants")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = document.documentID
                    let name = data["name"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let category = data["category"] as? String ?? ""

                    let restaurant = Restaurant(id: id, name: name, location: location, category: category )
                    self.restaurants.append(restaurant)
                }
            }
        }
    }

    func deleteRestaurants(_ restaurantsToDelete: [Restaurant]) {
        let database = Firestore.firestore()
        let batch = database.batch()

        for restaurant in restaurantsToDelete {
            let documentRef = database.collection("Restaurants").document(restaurant.id)
            batch.deleteDocument(documentRef)
        }

        batch.commit { error in
            if let error = error {
                print("Error deleting documents: \(error.localizedDescription)")
            } else {
                // Successfully deleted documents
                self.fetchRestaurants()
            }
        }
    }

    func fetchLists() {
        self.userLists.removeAll()
//        var newUserLists: [UserList] = []
        let database = Firestore.firestore()
        let user = Auth.auth().currentUser
        if user == nil {
            return
        }
        let userRef = database.collection("Users").document("\(user?.uid ?? "")")
        userRef.collection("Lists").getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()

                    let id = document.documentID
                    let name = data["Name"] as? String ?? ""

                    let restaurantRef = userRef.collection("Lists").document(id).collection("Restaurants")
                    restaurantRef.getDocuments { restaurantSnapshot, restaurantError in
                        guard restaurantError == nil else {
                            print(restaurantError!.localizedDescription)
                            return
                        }
                        var userListRestaurants: [UserListRestaurant] = []
                        if let restaurantSnapshot = restaurantSnapshot {
                            for restaurantDocument in restaurantSnapshot.documents {
                                let restaurantRef = restaurantDocument["Restaurant"] as? String ?? "2"
                                let restaurantScore = restaurantDocument["score"] as? String ?? "2"

                                let userListRestaurant =
                                UserListRestaurant(reference: restaurantRef, score: restaurantScore)
                                userListRestaurants.append(userListRestaurant)
                            }
                        }
                        let userList = UserList(name: name, restaurants: userListRestaurants)
//                        print("Buraya girizyoz")
                        self.userLists.append(userList)
//                        newUserLists.append(userList)
                    }
                }
//                self.userLists = Array(newUserLists)
            }
        }
    }

    func deleteList(_ list: UserList) {
        let database = Firestore.firestore()
        let user = Auth.auth().currentUser
        guard let userId = user?.uid else {
            return
        }

        let userRef = database.collection("Users").document(userId)
        let listRef = userRef.collection("Lists").document(list.name)

        // Delete the list document in Firestore
        listRef.delete { error in
            if let error = error {
                print("Error deleting list document: \(error.localizedDescription)")
                return
            }

            // Delete the list locally
            self.fetchLists()
        }
    }

    func addRestaurant(name: String, location: String, category: String) {
        let database = Firestore.firestore()
//        let ref = db.collection("Restaurants").document(name)
        let ref = database.collection("Restaurants")
//        ref.setData(["name": name,"location": location])

        ref.addDocument(data: ["name": name, "location": location, "category": category]) { (error) in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with auto-generated ID")
                }
            }
        fetchRestaurants()
    }

    func getListRestaurants(restaurantList: [UserListRestaurant]) {
        self.listRestaurants.removeAll()
        let database = Firestore.firestore()
        //        let ref = db.collection("Restaurants")
        for id in restaurantList {
            database.collection("Restaurants").document(id.reference).getDocument { (document, _) in
                if let document = document, document.exists {
                    if let name = document["name"] as? String,
                       let location = document["location"] as? String,
                       let category = document["category"] as? String {
                            let restaurant = Restaurant(id: id.reference,
                                                        name: name,
                                                        location: location,
                                                        category: category)
                        self.listRestaurants.append(restaurant)
                    }
                } else {
                    print("Restaurant with ID \(id) not found")
                }
            }
        }
    }

    func getListRestaurants2(listName: String) {
//        fetchLists()
//        var returnRestaurants: [Restaurant] = []
        self.listRestaurants.removeAll()
        // Find the UserList with the specified name
        if let userList = userLists.first(where: { $0.name == listName }) {
            // Access the restaurants property of the found UserList
            let restaurantReferences = userList.restaurants

            // Now you can work with the 'restaurants' array as needed
            print("Restaurants for \(listName): \(restaurantReferences)")

            for restaurantRef in restaurantReferences {
                if let desiredRestaurant = restaurants.first(where: {$0.id == restaurantRef.reference}) {
//                    returnRestaurants.append(desiredRestaurant)
                    self.listRestaurants.append(desiredRestaurant)
                } else {
                    print("No such restaurant exists.")
                }
            }

        } else {
            print("UserList with name \(listName) not found.")
        }
//        return returnRestaurants
    }

    func addRestaurantToList(name: String, restaurantsToAdd: [String]) {
        let database = Firestore.firestore()

//        let ref = db.collection("Restaurants").document(name)
//        print("Res to add: \(restaurantsToAdd[0])")
//        print("Name: \(restaurantsToAdd[0])")
        let user = Auth.auth().currentUser
        let userid = (user?.uid)!
        let ref = database.collection("Users")
        let listRef = ref.document(userid).collection("Lists").document(name)
//        ref.setData(["name": name,"location": location])
        for restaurant in restaurantsToAdd {
            listRef.collection("Restaurants").addDocument(data: ["Restaurant": restaurant, "score": "0"]) { (error) in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with auto-generated ID")
                }
            }
        }
    }

    func removeRestaurantFromList(listName: String, restaurantToRemove: Restaurant) {
        let database = Firestore.firestore()

        let user = Auth.auth().currentUser
        guard let userId = user?.uid else {
            return
        }

        let listRef = database.collection("Users").document(userId).collection("Lists").document(listName)
            listRef.collection("Restaurants")
            .whereField("Restaurant", isEqualTo: restaurantToRemove.id).getDocuments { (snapshot, error) in
            guard error == nil else {
                print("Error getting documents: \(error!.localizedDescription)")
                return
            }

            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let docRef = document.reference
                    docRef.delete { (error) in
                        if let error = error {
                            print("Error removing document: \(error)")
                        } else {
                            print("Document removed successfully")
//                            self.fetchLists()

                        }
                    }
                }
            }
        }
//        self.fetchLists()
    }

}
