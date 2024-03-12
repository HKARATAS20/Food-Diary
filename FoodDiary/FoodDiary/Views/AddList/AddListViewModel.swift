//
//  AddListViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 10.01.2024.
//

import Foundation

class AddListViewModel: ObservableObject {

    @Published var name = ""
    @Published var user = ""
    @Published var restaurants: [Restaurant] = []
    @Published var listManager = ListManager()
    @Published var restaurantTest = [Restaurant(id: "123", name: "Mahir", location: "Somewhere", category: "category")]

    func createList() {
        listManager.createList(listName: "\(name)", restaurants: restaurantTest)
    }
}
