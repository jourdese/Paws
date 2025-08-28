//
//  ContentView.swift
//  Paws
//
//  Created by Jourdese Palacio on 8/28/25.
//  Content View

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var pets: [Pet]
    var body: some View {
        NavigationStack {
            ScrollView {
                EmptyView()
            } //#Scrollview
            .overlay {
                if pets.isEmpty {
                    CustomContentUnavailableView(
                        icon: "dog.circle", title: "No Pets", description: "Add a new pet to get started"
                    )
                }
            }
        } //#NavigationStack
    }
}

#Preview("No Data") {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}
