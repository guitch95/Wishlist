//
//  ContentView.swift
//  Wishlist
//
//  Created by Guillaume Richard on 19/02/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    // modelContext provides a connection between the view and the modelContainer
    @Environment(\.modelContext) private var modelContext
    // Retrieve data from the modelContainer
    @Query private var wishes: [Wish]
    @State private var isAlertShowing = false
    @State private var newWish = ""
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                }
                .onDelete(perform: deleteWish)
            }
            .navigationTitle("Wishlist")
            .toolbar {
                Button {
                    isAlertShowing.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .alert("Create a new wish", isPresented: $isAlertShowing) {
                TextField("Enter a wish", text: $newWish)
                Button {
                    modelContext.insert(Wish(title: newWish))
                    newWish = ""
                } label: {
                    Text("Save")
                }
                
            }
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView(
                        "My wishlist",
                        systemImage: "heart.circle",
                        description: Text("No wishes yet. Add you first wish.")
                    )
                }
            }

        }
    }

    func deleteWish(_ indexSet: IndexSet) {
        for item in indexSet {
            let object = wishes[item]
            modelContext.delete(object)
        }
    }
}


#Preview("List with sample data"){
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Wish.self, configurations: config)

    container.mainContext.insert(Wish(title: "Master SwiftData"))
    container.mainContext.insert(Wish(title: "Buy a Vision Pro"))
    container.mainContext.insert(Wish(title: "Practice SwiftUI"))
    container.mainContext.insert(Wish(title: "Travel to New Zealand"))
    container.mainContext.insert(Wish(title: "Take some vacation"))
    
    return ContentView()
        .modelContainer(container)
}


#Preview("Empty List"){
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
