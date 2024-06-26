//
//  ContentView-ViewModel.swift
//  DexMate
//
//  Created by Jared Pateman on 29/04/2024.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        private let pokemonListURL: String = "https://pokeapi.co/api/v2/pokemon-species?limit=10000"
        @Published var results = [Result]()
        @Published var searchText = ""
        
        var filteredPokemon: [Result] {
            if searchText == "" { return results }
            return results.filter {
                $0.name.lowercased().contains(searchText.lowercased() )
            }
        }
        
        func getPokemonList() async{
            let url = URL(string: pokemonListURL)!
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let decodedResult: Results = try JSONDecoder().decode(Results.self, from: data)
                results = decodedResult.results
            } catch {
                // Do Nothing for now just log something went wrong
                print("Something went wrong: \(error.localizedDescription)")
            }
        }
    }
}
