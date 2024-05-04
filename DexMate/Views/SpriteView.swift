//
//  SpriteView.swift
//  DexMate
//
//  Created by Jared Pateman on 01/05/2024.
//

import SwiftUI

struct SpriteView: View {
    var sprite: String
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.gray)
                .opacity(0.3)
                .frame(width: 200, height: 200)
            
            if sprite.isEmpty {
                Text("No Image Found")
            } else {
                AsyncImage(url: URL(string: sprite)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .frame(maxWidth: 200)
                } placeholder: {
                    ProgressView().progressViewStyle(.circular)
                }
            }
        }
    }
}

#Preview {
    SpriteView(sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
}
