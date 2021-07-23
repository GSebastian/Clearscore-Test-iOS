//
//  Errors.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 22/07/2021.
//

import Foundation

enum MVVMError: LocalizedError {
    case missingViewModel
    case initFromStoryboard
    
    var errorDescription: String? {
        switch self {
        case .missingViewModel:
            return "Tried to initialise a view, but view model was missing."
        case .initFromStoryboard:
            return "Tried to initialise from a storyboard, but something went wrong"
        }
    }
}
