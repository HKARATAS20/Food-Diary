//
//  CardView.swift
//  FoodDiary
//
//  Created by Altay Karataş on 5.01.2024.
//

import SwiftUI

struct CardView: View {
    let name: String
    let count: Int
    let userName: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(count)", systemImage: "fork.knife.circle.fill")
                Spacer()
                Label("\(userName)", systemImage: "person.fill")
            }
            .font(.caption)

        }
        .padding()
        .foregroundColor(.white)
    }
}

struct CardView_Previews: PreviewProvider {

    static var previews: some View {
        CardView(name: "test", count: 12, userName: "Altay")
            .previewLayout(.fixed(width: 400, height: 60))
    }
 }
