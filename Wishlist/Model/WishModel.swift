//
//  Wish.swift
//  Wishlist
//
//  Created by Guillaume Richard on 19/02/2026.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
}
