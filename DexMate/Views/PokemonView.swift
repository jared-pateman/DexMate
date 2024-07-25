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
            
            if viewModel.hasSprite {
                SpriteView(sprite: viewModel.showingShinySprite ? viewModel.shinySprite : viewModel.normalSprite)
            } else {
                Text("No Image Found!")
            }
            
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
            
            if let preEvolution = viewModel.evolvesFrom {
                Text("Evolves from: \(preEvolution.capitalized)")
                    .font(.title3.bold())
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .task {
            await viewModel.getSpeciesInfo()
        }
    }
    
    init(url pokemonURL: String, name pokemonName: String) {
        self.viewModel = ViewModel(url: pokemonURL, name: pokemonName)
    }
}

#Preview {
    PokemonView(url: "https://pokeapi.co/api/v2/pokemon/1", name: "bulbasaur")
}
