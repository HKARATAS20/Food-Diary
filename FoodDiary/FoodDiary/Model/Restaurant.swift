//
//  Restaurant.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import Foundation

struct Restaurant: Hashable, Identifiable {
    var id: String
    var name: String
    var location: String
    var category: String
}
