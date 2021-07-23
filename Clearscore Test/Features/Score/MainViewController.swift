//
//  MainViewController.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Combine
import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var contentWrapperView: UIStackView!
    
    @IBOutlet weak var scoreWrapper: UIStackView!
    @IBOutlet weak var scoreView: ScoreView!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - Properties
        
    var viewModel: MainViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            viewModel.creditSuccessHandler = { [weak self] scoreViewModel, buttonText in
                self?.initScoreView(scoreViewModel: scoreViewModel,
                                    buttonText: buttonText)
            }
            viewModel.creditFailureHandler = { [weak self] in

            }
            if isViewLoaded { viewModel.viewDidLoad() }
        }
    }
    
    // MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel?.viewDidLoad()
    }
    
    private func initScoreView(scoreViewModel: ScoreViewModel,
                               buttonText: String) {
        
        viewModel?.scoreViewModel?.animationCompletionHandler = { [weak self] in
            UIView.animate(withDuration: 0.3) {
                self?.button.isHidden = false
                self?.button.layoutIfNeeded()
            }
        }
        scoreView.viewModel = viewModel?.scoreViewModel
        button.setTitle(buttonText, for: .normal)
        self.contentWrapperView.addArrangedSubview(self.scoreWrapper)
    }
}