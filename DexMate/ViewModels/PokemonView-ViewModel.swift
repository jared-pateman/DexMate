//
//  PokemonView-ViewModel.swift
//  DexMate
//
//  Created by Jared Pateman on 29/04/2024.
//

import Foundation

extension PokemonView {
    @MainActor class ViewModel: ObservableObject {
        @Published var pokemonSpeciesURL: String
        @Published var pokemonName: String
        
        @Published var pokemonId: Int = 0
        @Published var normalSprite: String = ""
        @Published var shinySprite: String = ""
        @Published var pokemonTypes = [PokemonTypes]()
        @Published var showingShinySprite: Bool = false
        @Published var hasSprite: Bool = true
        
        @Published var evolvesFrom: String?
        
        private var pokemonInfoURL: String = ""
        
        func getSpeciesInfo() async {
            guard let url = URL(string: pokemonSpeciesURL) else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from:url)
                let decodedResult = try JSONDecoder().decode(PokemonSpeciesInfo.self, from: data)
                
                for variety in decodedResult.varieties {
                    if variety.is_default {
                        pokemonInfoURL = variety.pokemon.url
                        break
                    }
                }
                
                if let evolvedFrom = decodedResult.evolves_from_species {
                    evolvesFrom = evolvedFrom.name
                }
                await getPokemonInfo()

            } catch {
                // Do Nothing for now just log something went wrong
                print("Something went wrong: \(error)")
            }
        }
        
        private func getPokemonInfo() async {
            guard let url = URL(string: pokemonInfoURL) else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decodedResult = try JSONDecoder().decode(PokemonInfo.self, from: data)
                pokemonId = decodedResult.id
                if let normalSpriteResult = decodedResult.sprites.front_default {
                    normalSprite = normalSpriteResult
                }
                if let shinySpriteResult = decodedResult.sprites.front_shiny {
                    shinySprite = shinySpriteResult
                }
                pokemonTypes = decodedResult.types
            } catch {
                // Do Nothing for now just log something went wrong
                print("Something went wrong: \(error)")
            }
        }
        
        init(url pokemonSpeciesURL: String, name pokemonName: String) {
            self.pokemonSpeciesURL = pokemonSpeciesURL
            self.pokemonName = pokemonName.capitalized
        }
    }
}
