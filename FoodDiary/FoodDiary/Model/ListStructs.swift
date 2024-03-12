//
//  ListStructs.swift
//  FoodDiary
//
//  Created by Altay Karataş on 4.01.2024.
//

import Foundation
// Model for storing general restaurant data
struct GeneralRestaurant {
    var id: String
    var name: String
    var location: String
}

// Model for storing restaurant data within a user's list
struct UserListRestaurant {
    var reference: String
    var score: String // Assuming score is a String, update it based on your actual data type
}

// Model for storing user list data
struct UserList {
    var name: String
    var restaurants: [UserListRestaurant]
}
