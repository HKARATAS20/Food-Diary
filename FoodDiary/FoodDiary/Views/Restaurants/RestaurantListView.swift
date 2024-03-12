//
//  RestaurantListView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.

import SwiftUI

struct RestaurantListView: View {

    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel: RestaurantListViewModel

    init() {
        let viewModel = RestaurantListViewModel(dataManager: DataManager())
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            ZStack {

                VStack(spacing: .zero) {
                    List {
                        ForEach(filteredRestaurants, id: \.self) { restaurant in

                            RestaurantCardView(
                                restaurantName: restaurant.name,
                                backgroundImageName: restaurant.category,
                                score: "5",
                                location: restaurant.location)
                            .listRowSeparator(.hidden)
                            .background(Color.background)
                            .cornerRadius(Radius.radius_2)
                            .listRowBackground(Color.background)
                            .onTapGesture {
                                viewModel.navigateToDetailView = true
                                viewModel.selectedRestaurant = restaurant
                                print("pressed ")
                            }
                        }

                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.background)
                    .navigationTitle("Restaurants")
                    .searchable(text: $viewModel.searchText)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.popupShown.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }))
                    .sheet(isPresented: $viewModel.popupShown) {
                        AddRestaurantView(popupShown: $viewModel.popupShown)
                    }
                    NavigationLink(
                        destination: RestaurantDetailView(restaurant: viewModel.selectedRestaurant),
                        isActive: $viewModel.navigateToDetailView) {
                            EmptyView()
                    }
                    .hidden()

                }
            }

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
    func deleteRestaurant(at offsets: IndexSet) {
        let restaurantsToDelete = offsets.map { filteredRestaurants[$0] }

        viewModel.deleteRestaurants(restaurantsToDelete: restaurantsToDelete)
    }
}

#Preview {
    RestaurantListView()
        .environmentObject(DataManager())
}
