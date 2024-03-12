//
//  RestaruantViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import Foundation

class RestaurantListViewModel: ObservableObject {

    @Published var popupShown = false
    @Published var searchText = ""
    @Published var navigateToDetailView = false
    @Published var selectedRestaurant: Restaurant = Restaurant(id: "", name: "", location: "", category: "")
    private var dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func deleteRestaurants (restaurantsToDelete: [Restaurant]) {

        dataManager.deleteRestaurants(restaurantsToDelete)
    }

}
