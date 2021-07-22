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
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scoreView: ScoreView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreView.animationCompletionHandler = { [unowned self] in
            UIView.animate(withDuration: 0.3) {
                self.button.isHidden = false
                self.stackView.layoutIfNeeded()
            }
        }
        
        self.cancellable = CreditService.getCreditData().sink { completion in
            print("Completed")
        } receiveValue: { response in
            print("\(response)")
        }
    }
}
