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
    
    // Note for interviewer: I'm using a `UIStackView` with center alignment purely as a way of saving some constraints
    // setting/removing when adding/removing subviews.
    @IBOutlet weak var contentWrapperView: UIStackView!
    
    // Loading state
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    // Failure state
    @IBOutlet private weak var failureWrapperView: UIView!
    @IBOutlet private weak var failureLabel: UILabel!
    @IBOutlet private weak var failureButton: UIButton!
    
    // Success state
    @IBOutlet private weak var scoreWrapperView: UIStackView!
    @IBOutlet private weak var scoreView: ScoreView!
    @IBOutlet private weak var scoreDetailButton: UIButton!
    
    // MARK: - IB Actions
    
    @IBAction func scoreDetailButtonTapped(_ sender: Any) {
        viewModel?.scoreDetailButtonTapped()
    }
    
    @IBAction func failureButtonTapped(_ sender: Any) {
        contentWrapperView.insertArrangedSubview(activityIndicatorView, at: 0)
        viewModel?.fetchScore()
    }
    
    // MARK: - Properties
    
    var viewModel: MainViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            viewModel.creditSuccessHandler = { [weak self] scoreViewModel, buttonText in
                self?.initScoreView(scoreViewModel: scoreViewModel,
                                    buttonText: buttonText)
            }
            viewModel.creditFailureHandler = { [weak self] descriptionText, buttonText in
                self?.initFailureView(descriptionText: descriptionText, buttonText: buttonText)
            }
            if isViewLoaded { viewModel.fetchScore() }
            title = viewModel.navigationTitle
        }
    }
        
    // MARK: - View Controller
    
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
            }
        }
        scoreView.viewModel = scoreViewModel
        scoreDetailButton.setTitle(buttonText, for: .normal)
        
        self.contentWrapperView.setChild(scoreWrapperView)
    }
    
    private func initFailureView(descriptionText: String, buttonText: String) {
        failureLabel.text = descriptionText
        failureButton.setTitle(buttonText, for: .normal)
        
        self.contentWrapperView.setChild(failureWrapperView)
    }
}
