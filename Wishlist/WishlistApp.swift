//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Guillaume Richard on 19/02/2026.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .modelContainer(for: Wish.self)

        }
    }
}
