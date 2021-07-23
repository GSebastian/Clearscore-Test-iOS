//
//  Coordinator.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var root: UIViewController? { get set }
    
    func start()
}
