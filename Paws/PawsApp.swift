//
//  PawsApp.swift
//  Paws
//
//  Created by Jourdese Palacio on 8/28/25.
//  Model Container

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
