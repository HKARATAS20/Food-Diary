//
//  AddRestaurantViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import Foundation
import Firebase

class AddRestaurantViewModel: ObservableObject {

    @Published var name = ""
    @Published var location = ""
    @Published var categories = ["Burger", "Pizza", "Turkish", "Italian", "Cafe", "Dessert"]

    private var dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

}
