//
//  RestaurantCardView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 17.01.2024.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurantName: String
    let backgroundImageName: String
    let score: String
    let location: String
    let scoreIcon: String = "star.fill"
    let locationIcon: String = "location.fill"

    var body: some View {
        VStack(spacing: 0) {
            // Background image with overlay for restaurant name
            ZStack {
                Image(backgroundImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 90) // Adjust as needed
                    .clipShape(Rectangle().offset(y: 0)) // Use Rectangle to clip the visible area

                // Apply gradient only to the visible area
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .overlay(
                    Text(restaurantName)
                        .font(.title) // Adjust the font size here
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading),
                    alignment: .bottomLeading
                )

            }
            .alignmentGuide(.bottom, computeValue: { dimension in
                            dimension[.bottom]
                        })
            // Bottom half with score and location
            VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "fork.knife")
                                    .font(.system(size: 18))
                                    .padding()
//                                Text("\(score)")
//                                    .font(.headline)
                                Spacer()

                                Image(systemName: locationIcon)
                                    .font(.system(size: 18))
//                                    .padding()
                                Text("\(location)")
                                    .font(.headline)
                            }
                        }
            .padding()
            .frame(height: 55, alignment: .center)
            .background(.restaurantCardBackground)
            .foregroundColor(.white)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 380, height: 145)
//        .padding()
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCardView(
            restaurantName: "Example Restaurant",
            backgroundImageName: "BurgerImage",
            score: "4.5",
            location: "City, Country"
        )
        .frame(height: 150)
    }
}
