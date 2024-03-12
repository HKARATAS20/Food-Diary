//
//  LoginView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 30.12.2023.
//

import SwiftUI
import Firebase

struct LoginView: View {

    @Binding var userLoggedIn: Bool
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {

        NavigationView {
            ZStack {

                Color.background

                VStack {

                    TitleText(text: "Welcome!")
                        .padding(.top, 150)

                    if  viewModel.registerShown {

                        registerFieldsView

                    } else {

                        loginFieldsView

                    }

                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)

                    Spacer(minLength: 0)

                }
                .navigationBarTitle("Food Diary", displayMode: .large)

                .onAppear {
                    Auth.auth().addStateDidChangeListener { _, user in
                        if user != nil {
                            userLoggedIn = true

                        } else {
                            userLoggedIn =  false
                        }
                    }
                }
            }
            .background(Color.background)
            .ignoresSafeArea()
        }
    }

    private var registerFieldsView: some View {
        VStack {
            TextFieldDS(value: $viewModel.firstName, placeholder: "First Name")
                .padding(.horizontal, Spacing.spacing_2)

            TextFieldDS(value: $viewModel.lastName, placeholder: "Last Name")
                .padding(.horizontal, Spacing.spacing_2)

            TextFieldDS(value: $viewModel.userName, placeholder: "Username")
                .padding(.horizontal, Spacing.spacing_2)

            TextFieldDS(value: $viewModel.email, placeholder: "Email")
                .padding(.horizontal, Spacing.spacing_2)
                .keyboardType(.emailAddress)

            SecureTextFieldDS(value: $viewModel.password, placeholder: "Password")
                .padding(.horizontal, Spacing.spacing_2)

            ButtonDS(buttonTitle: "Sign Up", action: viewModel.registerAction)

            LinkButtonDS(buttonTitle: viewModel.loginTitle, action: {
                viewModel.registerShown.toggle()
                viewModel.errorMessage = ""
            })

        }

    }

    private var loginFieldsView: some View {
        VStack {

            TextFieldDS(value: $viewModel.email, placeholder: "Email")
                .padding(.horizontal, Spacing.spacing_2)
                .keyboardType(.emailAddress)

            SecureTextFieldDS(value: $viewModel.password, placeholder: "Password")
                .padding(.horizontal, Spacing.spacing_2)
                .padding(.bottom, 100)
            ButtonDS(buttonTitle: "Login", action: viewModel.loginAction)

            LinkButtonDS(buttonTitle: viewModel.registerTitle, action: {
                viewModel.registerShown.toggle()
                viewModel.errorMessage = ""
            })

        }
    }
}

#Preview {
    LoginView(
        userLoggedIn: .constant(false)
    )

}
