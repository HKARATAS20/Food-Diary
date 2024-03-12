//
//  AddResToListView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 10.01.2024.
//

import SwiftUI

struct AddResToListView: View {

    @EnvironmentObject var dataManager: DataManager
    @Binding var popupShown: Bool
    @Binding var listRestaurants: [Restaurant]
    @StateObject private var viewModel = AddResToListViewModel()
    let listName: String

    var body: some View {
        VStack {
            List {
                ForEach(filteredRestaurants) { restaurant in
                    Button(action: {
                        viewModel.toggleSelection(for: restaurant.id,
                                                  listRestaurants: listRestaurants)
                    }) {
                        HStack {
                            Text(restaurant.name)
                            Spacer()
                            if viewModel.selectedItems.contains(restaurant.id) ||
                                listRestaurants.contains(where: { $0.id == restaurant.id }) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))

            ButtonDS(buttonTitle: "Save") {
                dataManager.addRestaurantToList(name: self.listName, restaurantsToAdd: Array(viewModel.selectedItems))
                dataManager.fetchLists()
                popupShown.toggle()
                fetchRestaurants()
            }
        }
    }

    private func fetchRestaurants() {
        let selectedIDs = Array(viewModel.selectedItems)
        let selectedRestaurants = dataManager.restaurants.filter { restaurant in
            return selectedIDs.contains(restaurant.id)
        }
        for restaurant in selectedRestaurants {
            listRestaurants.append(restaurant)
            print("to list restaurants\(listRestaurants)")
        }
    }

    private var filteredRestaurants: [Restaurant] {
        if viewModel.searchText.isEmpty {
            return dataManager.restaurants
        } else {
            return dataManager.restaurants.filter {
                $0.name.localizedCaseInsensitiveContains(viewModel.searchText)
            }
        }
    }
}

#Preview {
    AddResToListView(popupShown: .constant(false),
                     listRestaurants: .constant([Restaurant(id: "", name: "", location: "", category: "")]),
                     listName: "")
}
