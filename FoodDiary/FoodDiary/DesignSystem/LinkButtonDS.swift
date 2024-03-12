//
//  LinkButton.swift
//  FoodDiary
//
//  Created by Altay Karataş on 2.01.2024.
//

import SwiftUI

struct LinkButtonDS: View {

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
                .foregroundStyle(.button)

        }
    }
}

#Preview {
    LinkButtonDS(buttonTitle: "test") { }
}
