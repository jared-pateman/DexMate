//
//  ContentView.swift
//  DexMate
//
//  Created by Jared Pateman on 29/04/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredPokemon, id: \.self) { result in
                VStack(alignment: .leading) {
                    NavigationLink {
                        PokemonView(url: result.url, name: result.name)
                    } label: {
                        Text(result.name.capitalized)
                            .font(.title2)
                    }
                }
            }
            .task {
                await viewModel.getPokemonList()
            }
            .navigationTitle("Pokedex")
            .searchable(text: $viewModel.searchText)
            .autocorrectionDisabled()
        }
    }
}

#Preview {
    ContentView()
}
