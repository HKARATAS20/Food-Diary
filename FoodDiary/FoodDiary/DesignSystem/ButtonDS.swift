//
//  ButtonDS.swift
//  FoodDiary
//
//  Created by Altay Karataş on 2.01.2024.
//

import SwiftUI

struct ButtonDS: View {

    private let buttonTitle: String
    private let action: () -> Void

    init(
        buttonTitle: String,
        action: @escaping () -> Void
    ) {
        self.buttonTitle = buttonTitle
        self.action = action
    }

    var body: some View {

        Button(action: action) {
            Text(buttonTitle)
                .foregroundColor(.buttonText)
                .padding(.horizontal, Spacing.spacing_5)
                .padding(.vertical, Spacing.spacing_1)
                .background(.button)
                .clipShape(RoundedRectangle(cornerRadius: Radius.radius_4))
        }
        .padding(.vertical, Spacing.spacing_2)
    }
}

#Preview {
    ButtonDS(buttonTitle: "test") { }
}
