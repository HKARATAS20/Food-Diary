//
//  ContentView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 20.12.2023.
//

import SwiftUI
import Firebase

struct HomeView: View {

    @State var userLoggedIn = false
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            if userLoggedIn {

                    TabView {

                        Group {
                            RestaurantListView()
                                .tabItem {
                                    Label("Restaurants", systemImage: "fork.knife")
                                }
                            ListView()
                                .tabItem {
                                    Label("Lists", systemImage: "list.dash")
                                }
                            ProfileView()
                                .tabItem {
                                    Label("Profile", systemImage: "person.fill")
                                }
                        }
                        .toolbarBackground(Color.background, for: .tabBar)

                    }

            } else {
                LoginView(userLoggedIn: $userLoggedIn)
            }
        }
        .onAppear {
            viewModel.loadUser()
        }
    }
}

#Preview {
    HomeView()
}
