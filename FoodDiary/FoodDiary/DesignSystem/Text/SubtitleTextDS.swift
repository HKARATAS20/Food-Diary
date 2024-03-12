//
//  SubtitleTextDS.swift
//  FoodDiary
//
//  Created by Altay Karataş on 24.01.2024.
//

import SwiftUI

struct SubtitleTextDS: View {

    private let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .lineLimit(2)
            .font(.title3)
            .padding(.vertical, Spacing.spacing_2)
            .padding(.horizontal, Spacing.spacing_2)
    }
}

#Preview {
    SubtitleTextDS(text: "Test")
}
