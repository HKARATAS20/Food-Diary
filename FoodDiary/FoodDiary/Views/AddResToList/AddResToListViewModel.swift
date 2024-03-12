//
//  AddResToListViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 14.01.2024.
//

import Foundation
import Firebase

class AddResToListViewModel: ObservableObject {

    @Published var addedRestaturants: [Restaurant]  = []
    @Published var location = ""
    @Published var selectedItems: Set<String> = []
    @Published var searchText = ""

    func toggleSelection(for itemId: String, listRestaurants: [Restaurant]) {

        if listRestaurants.contains(where: { $0.id == itemId }) {

        } else {
            if selectedItems.contains(itemId) {
                selectedItems.remove(itemId)
            } else {
                selectedItems.insert(itemId)
            }
        }
    }
}
