//
//  ImageDS.swift
//  FoodDiary
//
//  Created by Altay Karataş on 24.01.2024.
//

import SwiftUI

struct ImageDS: View {

    @State var category: String

    var body: some View {
        Image(category)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 400, height: 300)
            .clipShape(RoundedRectangle(cornerRadius: Radius.radius_4))
            .overlay {
                RoundedRectangle(cornerRadius: Radius.radius_4).stroke(.white, lineWidth: Radius.radius_1)
            }
            .shadow(radius: Radius.radius_2)
            .padding(Spacing.spacing_2)
    }
}

#Preview {
    ImageDS(category: "Burger")
}
