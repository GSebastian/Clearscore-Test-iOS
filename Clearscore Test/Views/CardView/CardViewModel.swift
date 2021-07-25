//
//  CardViewModel.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 24/07/2021.
//

import UIKit

class CardViewModel {
    
    let image: UIImage
    let primaryText: String
    let secondaryText: String
    
    init(image: UIImage,
         primaryText: String,
         secondaryText: String) {
        
        self.image = image
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
}
