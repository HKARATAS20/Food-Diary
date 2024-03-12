//
//  RestaurantDetailView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 24.01.2024.
//

import SwiftUI

struct RestaurantDetailView: View {
    @State var restaurant: Restaurant

    var body: some View {
        ZStack {
            Color.background
            VStack {

                ImageDS(category: restaurant.category)

                SubtitleTextDS(text: "Name: \(restaurant.name)")

                SubtitleTextDS(text: "Locaton: \(restaurant.location)")

                SubtitleTextDS(text: "Category: \(restaurant.category)")

                Spacer()
            }
            .navigationTitle(restaurant.name)
        }
        .background(Color.background)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant:
                                Restaurant(id: "1",
                                           name: "Sample Restaurant",
                                           location: "Sample Location",
                                           category: "Burger"))
    }
}
