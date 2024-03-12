//
//  AddRestaurantView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import SwiftUI

struct AddRestaurantView: View {

    @EnvironmentObject var dataManager: DataManager
    @Binding var popupShown: Bool
    @StateObject private var viewModel: AddRestaurantViewModel
    @State private var selectedCategoryIndex = 0

    init(popupShown: Binding<Bool>) {
        _popupShown = popupShown
        let viewModel = AddRestaurantViewModel(dataManager: DataManager())
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color.background
            VStack {
                Text("Add a New Restaurant")
                    .font(.title2)

                TextFieldDS(value: $viewModel.name, placeholder: "Name")

                TextFieldDS(value: $viewModel.location, placeholder: "Location" )
                List {
                    Picker("Select Category", selection: $selectedCategoryIndex) {
                        ForEach(0..<viewModel.categories.count, id: \.self) {
                            Text(viewModel.categories[$0]).tag(viewModel.categories[$0])
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .frame(height: 100)

                ButtonDS(buttonTitle: "Save") {
                    dataManager.addRestaurant(name: viewModel.name,
                                              location: viewModel.location,
                                              category: viewModel.categories[selectedCategoryIndex])
                    popupShown.toggle()

                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AddRestaurantView(popupShown: .constant(true))
}
