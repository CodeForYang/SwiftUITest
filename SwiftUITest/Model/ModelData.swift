//
//  ModelData.swift
//  SwiftUITest
//
//  Created by 杨佩 on 2026/4/28.
//

import Foundation

@Observable
class ModelData {
    var landmarks: [Landmark] = load(filename: "landmarkData.json")
    var hikes: [Hike] = load(filename: "hikeData.json")
    var profile = Profile.default
    
    var features:[Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}

func load<T: Decodable>(filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("No file found under \(filename)")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Failed to read file \(filename)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Failed to decode file \(error)")
    }
            
}
