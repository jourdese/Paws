//
//  Pet.swift
//  Paws
//
//  Created by Jourdese Palacio on 8/28/25.
//  Swift Data Model

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
