//
//  ListViewModel.swift
//  FoodDiary
//
//  Created by Altay Karataş on 4.01.2024.
//

import Foundation
import Firebase

class ListViewModel: ObservableObject {

    @Published var popupShown = false
    @Published var userLists: [UserList] = []
    @Published var generalRestaurants: [GeneralRestaurant] = []
    @Published var dataFetched = false
    @Published var navigateToSublist = false
    @Published var listPopupShown = false
    @Published var sublistName = ""
    let user = Auth.auth().currentUser
    var userManager = UserManager()
    @Published var listManager = ListManager()
    @Published var sublistList: [UserListRestaurant] = []
    @Published var testList: [Restaurant] = []
    @Published var searchText = ""

    private var dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }

    func deleteList(listsToDelete: [UserList] ) {
        dataManager.deleteList(listsToDelete[0])

    }

}
