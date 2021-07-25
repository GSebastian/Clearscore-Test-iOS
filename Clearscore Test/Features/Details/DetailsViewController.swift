//
//  DetailsViewController.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
        
    @IBOutlet private weak var primaryLabel: UILabel!
    @IBOutlet private weak var secondaryLabel: UILabel!
    
    @IBOutlet private var cardViews: [CardView]!
    
    // MARK: - Properties
    
    var viewModel: DetailsViewModel? {
        didSet {
            if isViewLoaded { initViews() }
        }
    }
    
    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    private func initViews() {
        guard let viewModel = viewModel else {
            preconditionFailure(MVVMError.missingViewModel.errorDescription ?? "")
        }
        zip(cardViews, viewModel.cardViewModels).forEach({ $0.0.viewModel = $0.1 })
        primaryLabel.text = viewModel.primaryText
        secondaryLabel.text = viewModel.secondaryText
    }
}
