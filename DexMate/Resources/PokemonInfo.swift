//
//  Pokemon.swift
//  DexMate
//
//  Created by Jared Pateman on 29/04/2024.
//

import Foundation

struct PokemonInfo: Codable {
    var id: Int
    var name: String
    var sprites: Sprites
    var types: [PokemonTypes]
}

struct Sprites: Codable {
    var front_default: String
    var front_shiny: String
}

struct PokemonTypes: Codable {
    var type: TypeElement
}

struct TypeElement: Codable {
    var name: String
}
