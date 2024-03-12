//
//  SublistViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 10.01.2024.
//

import Foundation

class SublistViewModel: ObservableObject {

    @Published var fetchedRestaurantList: [Restaurant] = []
    @Published var listPopupShown = false
    @Published var listName: String = ""

    private var dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func deleteRestaurant(restaurant: [Restaurant]) {
        dataManager.removeRestaurantFromList(listName: listName, restaurantToRemove: restaurant[0])
        dataManager.fetchLists()
    }

}
