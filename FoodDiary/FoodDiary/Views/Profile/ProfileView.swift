//
//  ProfileView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 8.01.2024.
//

import SwiftUI

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            Color.background
            VStack {

                SubtitleTextDS(text: "Email: \(viewModel.email)")

                SubtitleTextDS(text: "Username: \(viewModel.user?.displayName ?? "")")

                ButtonDS(buttonTitle: "Sign Out") {
                    viewModel.signOut()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}
