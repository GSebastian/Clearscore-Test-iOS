//
//  Coordinator.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import Foundation
import UIKit

// Note for interviewer: For such a small app, MVVM and a Coordinator seemed most appropriate.

protocol Coordinator: AnyObject {
    
    var root: UIViewController? { get set }
    
    func start()
}
