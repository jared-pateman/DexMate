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
            List(viewModel.results, id: \.self) { result in
                VStack(alignment: .leading) {
                    NavigationLink {
                        PokemonView(url: result.url)
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
        }
    }
}

#Preview {
    ContentView()
}
