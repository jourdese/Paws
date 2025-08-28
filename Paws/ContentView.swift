//
//  ContentView.swift
//  Paws
//
//  Created by Jourdese Palacio on 8/28/25.
//  Vertical Grid Layout

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var pets: [Pet]
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
    ]
    
    func addPet() {
        let pet = Pet(name: "Best")
        modelContext.insert(pet)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout){
                    GridRow {
                        ForEach(pets) {
                            pet in NavigationLink(destination: EmptyView()){
                                VStack {
                                    if let imageData = pet.photo {
                                        if let image = UIImage(data: imageData) {
                                            Image(uiImage: image)
                                        }
                                    } else {
                                        Image(systemName: "pawprint.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(40)
                                            .foregroundStyle(.quaternary)
                                    }
                                    Spacer()
                                    
                                    Text(pet.name)
                                        .font(.title.weight(.light))
                                        .padding(.vertical)
                                    
                                    Spacer()
                                } //#VStack
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                                    maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                            } //#NavigationLink
                            .foregroundStyle(.primary)
                        } //#Loop
                    } //#GridRow
                } //#GridLayout
            } //#Scrollview
            .navigationTitle(pets.isEmpty ? "" : "Pets")
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

#Preview("Sample Data") {
    ContentView()
        .modelContainer(Pet.preview)
}

#Preview("No Data") {
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}
