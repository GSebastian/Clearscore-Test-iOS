//
//  MainCoordinator.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    private weak var window: UIWindow?
    
    weak var root: UIViewController?
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Methods
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard
            let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            preconditionFailure(MVVMError.initFromStoryboard.errorDescription ?? "")
        }
        
        vc.viewModel = MainViewModel()
        vc.coordinatorDelegate = self
       
        let navVC = UINavigationController(rootViewController: vc)
        
        root = navVC
        
        window?.rootViewController = navVC
    }
}

// MARK: - MainCoordinatorProtocol

extension MainCoordinator: MainCoordinatorProtocol {
    
    func showDetail() {
        
    }
}
