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
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var scoreWrapperView: UIStackView!
    @IBOutlet weak var scoreView: ScoreView!
    @IBOutlet weak var scoreDetailButton: UIButton!
    
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
            if isViewLoaded { viewModel.fetchScore() }
            title = viewModel.navigationTitle
        }
    }
    
    var coordinatorDelegate: MainCoordinatorProtocol?
    
    // MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        contentWrapperView.setChild(activityIndicatorView)
        
        viewModel?.viewDidLoad()
    }
    
    private func initScoreView(scoreViewModel: ScoreViewModel,
                               buttonText: String) {
        
        scoreViewModel.animationCompletionHandler = { [weak self] in
            UIView.animate(withDuration: 0.4) {
                self?.scoreDetailButton.isHidden = false
                self?.scoreDetailButton.layoutIfNeeded()
            }
        }
        scoreView.viewModel = scoreViewModel
        scoreDetailButton.setTitle(buttonText, for: .normal)
        
        self.contentWrapperView.setChild(scoreWrapperView)
    }
}
