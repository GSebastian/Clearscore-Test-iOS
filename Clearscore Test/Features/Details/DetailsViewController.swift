//
//  DetailsViewController.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import UIKit

// Note for interviewer: With this view controller, I just wanted to showcase a more complex layout created with
// Auto Layout (UIScrollView, UIStackView). As time was short, I skipped the automated testing for this, and I also din't use a UITableView.
//
// Generally, UITableViews carry a lot of (code) overhead, so I don't shy away from UIScrollView whenever the elements
// in the list are few (in this case only 5 elements in a list that doesn't dynamically grow).

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
        // Note for interviewer: this isn't super safe, but did it for lack of more time. Probably would at least have
        // some good tests for this in production.
        zip(cardViews, viewModel.cardViewModels).forEach({ $0.0.viewModel = $0.1 })
        primaryLabel.text = viewModel.primaryText
        secondaryLabel.text = viewModel.secondaryText
    }
}
