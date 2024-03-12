//
//  ListView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 4.01.2024.
//

import SwiftUI

struct ListView: View {

    @StateObject private var viewModel: ListViewModel
    @EnvironmentObject var dataManager: DataManager

    init() {
        let viewModel = ListViewModel(dataManager: DataManager())
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {

                VStack {

                    List {
                        ForEach(filteredUserLists, id: \.name) { list in
                            CardView(name: list.name,
                                     count: list.restaurants.count-1,
                                     userName: viewModel.user?.displayName ?? "unknown")
                                .listRowSeparator(.hidden)
                                .background(Color.cardBackground)
                                .cornerRadius(Radius.radius_2)
                                .listRowBackground(Color.background)
                                .onTapGesture {
                                    viewModel.sublistName = list.name
                                    viewModel.sublistList = list.restaurants
                                    viewModel.navigateToSublist.toggle()
                                    dataManager.getListRestaurants2(listName: list.name)
                                }
                        }
                        .onDelete(perform: deleteList)
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.background)
                    .listStyle(.plain)
                    .searchable(text: $viewModel.searchText)
                    .onAppear {
//                        viewModel.getUserList()
                        if viewModel.user != nil && !viewModel.dataFetched {
                            dataManager.fetchLists()
                            viewModel.dataFetched = true
                        }
                    }
                    .navigationTitle("Lists")
                    .navigationDestination(
                        isPresented: $viewModel.navigateToSublist) {
                            SublistView(listName: viewModel.sublistName)
                         }
                    // Trailing yaptım bunu ama fazla mı yukarıda kaldı acaba
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.listPopupShown.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }))
                    .sheet(isPresented: $viewModel.listPopupShown) {
                        AddListView(popupShown: $viewModel.listPopupShown)
                    }
                }
            }
        }
    }

    private var filteredUserLists: [UserList] {
        if viewModel.searchText.isEmpty {
            return dataManager.userLists
        } else {
            return dataManager.userLists.filter { $0.name.localizedCaseInsensitiveContains(viewModel.searchText) }
        }
    }

    func deleteList(at offsets: IndexSet) {
        let listToDelete = offsets.map { filteredUserLists[$0] }

        // Call your ViewModel's method to delete the objects from the database
        viewModel.deleteList(listsToDelete: listToDelete)
    }

}

#Preview {
    ListView()
}
