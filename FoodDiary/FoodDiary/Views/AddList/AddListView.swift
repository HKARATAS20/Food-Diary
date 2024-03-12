//
//  AddListView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import SwiftUI

struct AddListView: View {

    @EnvironmentObject var dataManager: DataManager
    @Binding var popupShown: Bool
    @StateObject private var viewModel = AddListViewModel()

    var body: some View {
        ZStack {
            Color.background
            VStack {
                TitleText(text: "Create a new list")

                TextFieldDS(value: $viewModel.name, placeholder: "Name")

                ButtonDS(buttonTitle: "Save") {
                    viewModel.createList()
                    dataManager.fetchLists()
                    popupShown.toggle()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AddListView(popupShown: .constant(true))
}
