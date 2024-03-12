//
//  TextField.swift
//  FoodDiary
//
//  Created by Altay Karataş on 3.01.2024.
//

import SwiftUI

struct TextFieldDS: View {

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

        TextField(placeholder, text: $value)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .padding(.vertical, Spacing.spacing_0_5)
            .padding(.horizontal, Spacing.spacing_4)
            .autocapitalization(.none)
    }
}

#Preview {
    TextFieldDS(
        value: .constant("test"),
        placeholder: "test"

    )
}
