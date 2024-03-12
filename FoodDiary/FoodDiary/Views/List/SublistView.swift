//
//  SublistView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 9.01.2024.
//

import SwiftUI

struct SublistView: View {

    var listName: String
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel: SublistViewModel
    var fetchedRestaurantList: [Restaurant] = []

    init(listName: String) {
        let viewModel = SublistViewModel(dataManager: DataManager())
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.listName = listName
    }
    var body: some View {
        NavigationStack {

            ZStack {
                Color.background
                List {
                    ForEach(viewModel.fetchedRestaurantList) { restaurant in
                        VStack(alignment: .leading) {

                            Text(restaurant.name)
                                .foregroundStyle(.white)

                            Text("Location: \(restaurant.location)")
                                .font(.subheadline)
                                .foregroundColor(Color.background)
                        }
                        .listRowBackground(Color.restaurantCardBackground)
                    }
                    .onDelete { indices in
                        deleteRestaurant(at: indices)
                    }
//                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                        Button {
//                            print("Swiped from left to right")
//                        } label: {
//                            Label("Details", systemImage: "list.dash")
//                        }
//                        .tint(.mint)
//                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.background)
            }
        }
        .navigationTitle(listName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            viewModel.listPopupShown.toggle()
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $viewModel.listPopupShown) {
            NavigationView { AddResToListView(popupShown: $viewModel.listPopupShown,
                                 listRestaurants: $viewModel.fetchedRestaurantList,
                                 listName: listName)
            }
        }
        .onAppear {
            viewModel.fetchedRestaurantList = dataManager.listRestaurants
            self.viewModel.listName = listName
        }
    }

    func deleteRestaurant(at offsets: IndexSet) {
        let listToDelete = offsets.map { viewModel.fetchedRestaurantList[$0] }

        viewModel.deleteRestaurant(restaurant: listToDelete)
        dataManager.fetchLists()
        viewModel.fetchedRestaurantList.removeAll { $0.id == listToDelete[0].id }

    }
}

#Preview {
    SublistView(listName: "test")
}
