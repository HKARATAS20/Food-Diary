//
//  SecureTextFieldDS.swift
//  FoodDiary
//
//  Created by Altay Karataş on 8.01.2024.
//

import SwiftUI

struct SecureTextFieldDS: View {

    @Binding private var value: String
    private let placeholder: String

    init(
        value: Binding<String>,
        placeholder: String
    ) {
        _value = value
        self.placeholder = placeholder

    }

    var body: some View {

        SecureField(placeholder, text: $value)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .padding(.vertical, Spacing.spacing_0_5)
            .padding(.horizontal, Spacing.spacing_4)
    }
}

#Preview {
    SecureTextFieldDS(
        value: .constant("test"),
        placeholder: "test"

    )
}
