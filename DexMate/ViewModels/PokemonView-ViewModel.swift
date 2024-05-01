//
//  PokemonView-ViewModel.swift
//  DexMate
//
//  Created by Jared Pateman on 29/04/2024.
//

import Foundation

extension PokemonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var pokemonInfoURL: String
        @Published var pokemonId: Int = 0
        @Published var pokemonName: String = ""
        @Published var normalSprite: String = ""
        @Published var shinySprite: String = ""
        @Published var showingShinySprite: Bool = false
        
        func getPokemonInfo() async {
            guard let url = URL(string: pokemonInfoURL) else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decodedResult = try JSONDecoder().decode(PokemonInfo.self, from: data)
                pokemonId = decodedResult.id
                pokemonName = decodedResult.name
                normalSprite = decodedResult.sprites.front_default
                shinySprite = decodedResult.sprites.front_shiny
            } catch {
                // Do Nothing for now just log something went wrong
                print("Something went wrong: \(error)")
            }
        }
        
        init(url pokemonInfoURL: String) {
            self.pokemonInfoURL = pokemonInfoURL
        }
    }
}
