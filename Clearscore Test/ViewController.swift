//
//  ViewController.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Combine
import UIKit

class ViewController: UIViewController {

    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cancellable = CreditService.getCreditData().sink { completion in
            print("Completed")
        } receiveValue: { response in
            print("\(response)")
        }
    }
}
