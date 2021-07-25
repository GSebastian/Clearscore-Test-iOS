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
        // Note for interviewer: I would usually use xibs in production, as storyboard files don't scale well - they
        // get really slow to render when there are lots of view controllers on them!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Note for interviewer: I'd probably move L32 to an extension that uses type(of:) to guard against typos
        guard
            let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            preconditionFailure(MVVMError.initFromStoryboard.errorDescription ?? "")
        }
        
        vc.viewModel = MainViewModel(coordinatorDelegate: self)
       
        let navVC = UINavigationController(rootViewController: vc)
        
        root = navVC
        
        window?.rootViewController = navVC
    }
}

// MARK: - MainCoordinatorDelegate

extension MainCoordinator: MainCoordinatorDelegate {
    
    func showDetail(creditResponse: CreditResponse) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard
            let vc = storyboard.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else {
            preconditionFailure(MVVMError.initFromStoryboard.errorDescription ?? "")
        }
        
        vc.viewModel = DetailsViewModel(creditResponse: creditResponse)
        
        root?.present(vc, animated: true, completion: nil)
    }
}
