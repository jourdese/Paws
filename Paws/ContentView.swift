//
//  ContentView.swift
//  Paws
//
//  Created by Jourdese Palacio on 8/28/25.
//  Delete button

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var pets: [Pet]
    
    @State private var path = [Pet]()
    @State private var isEditing: Bool = false
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
    ]
    
    func addPet() {
        isEditing = false
        let pet = Pet(name: "Best")
        modelContext.insert(pet)
        path = [pet]
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: layout){
                    GridRow {
                        ForEach(pets) {
                            pet in NavigationLink(value: pet){
                                VStack {
                                    if let imageData = pet.photo {
                                        if let image = UIImage(data: imageData) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
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
                                .overlay(alignment: .topTrailing) {
                                    if isEditing {
                                        Menu {
                                            Button(role: .destructive) {
                                                modelContext.delete(pet)
                                                try? modelContext.save()
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        } label : {
                                            Image(systemName: "trash.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 36, height: 36)
                                                .foregroundStyle(.red)
                                                .symbolRenderingMode(.multicolor)
                                                .padding()
                                        }
                                    }
                                }
                            } //#NavigationLink
                            .foregroundStyle(.primary)
                        } //#Loop
                    } //#GridRow
                } //#GridLayout
            } //#Scrollview
            .navigationTitle(pets.isEmpty ? "" : "Pets")
            .navigationDestination(for: Pet.self, destination: EditPetView.init)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add a new pet", systemImage: "plus.circle", action: addPet)
                }
            }
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
