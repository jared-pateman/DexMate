//
//  APIResults.swift
//  DexMate
//
//  Created by Jared Pateman on 29/04/2024.
//

import Foundation

class Result: Codable, Hashable {
    var name: String
    var url: String
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
    }
}

class Results: Codable {
    var results: [Result]
}
