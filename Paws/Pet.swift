//
//  Pet.swift
//  Paws
//
//  Created by Jourdese Palacio on 8/28/25.
//  Sample data

import Foundation
import SwiftData

@Model
final class Pet {
    var name: String
    @Attribute(.externalStorage) var photo: Data?
    
    init(name: String, photo: Data? = nil){
        self.name = name
        self.photo = photo
    }
}

extension Pet {
    @MainActor
    static var preview: ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: configuration)
        
        container.mainContext.insert(Pet(name: "Garlic"))
        container.mainContext.insert(Pet(name: "Koko"))
        container.mainContext.insert(Pet(name: "Chocnut"))
        container.mainContext.insert(Pet(name: "Yuki"))
        container.mainContext.insert(Pet(name: "Samson"))
        container.mainContext.insert(Pet(name: "Kingkong"))
        container.mainContext.insert(Pet(name: "K.O"))
        container.mainContext.insert(Pet(name: "Simba"))
        
        return container
    }
}
