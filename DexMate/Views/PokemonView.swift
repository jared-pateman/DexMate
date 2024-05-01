//
//  PokemonView.swift
//  DexMate
//
//  Created by Jared Pateman on 29/04/2024.
//

import SwiftUI

struct PokemonView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("#\(viewModel.pokemonId) \(viewModel.pokemonName.capitalized)")
                .font(.largeTitle.bold())
                .frame(alignment: .topLeading)
            
            SpriteView(sprite: viewModel.showingShinySprite ? viewModel.shinySprite : viewModel.normalSprite)
            
            Toggle(isOn: $viewModel.showingShinySprite) {
                Text("Show Shiny Sprite?")
            }
            
            HStack {
                Text("Types:")
                    .font(.title3.bold())
                
                Spacer()
                
                ForEach(viewModel.pokemonTypes, id: \.self.type.name) { type in
                    Text(type.type.name.capitalized)
                        .fontWeight(.bold)
                        .padding()
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .task {
            await viewModel.getPokemonInfo()
        }
    }
    
    init(url pokemonURL: String) {
        self.viewModel = ViewModel(url: pokemonURL)
    }
}

#Preview {
    PokemonView(url: "https://pokeapi.co/api/v2/pokemon/1")
}
