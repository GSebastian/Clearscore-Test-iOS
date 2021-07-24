//
//  CardView.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 24/07/2021.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    
    private static var nibName = "CardView"
    
    // MARK: - Outlets
    
    @IBOutlet private var rootView: UIView!
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var primaryLabel: UILabel!
    @IBOutlet private weak var secondaryLabel: UILabel!
    
    // MARK: - Other Properties
    
    var viewModel: CardViewModel? = nil {
        didSet {
            initLabels()
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed(Self.nibName, owner: self, options: nil)
        addSubview(rootView)
        rootView.frame = bounds
        rootView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        layer.cornerRadius = 10
        rootView.layer.cornerRadius = 10
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
    }
    
    private func initLabels() {
        guard let viewModel = viewModel else {
            preconditionFailure(MVVMError.missingViewModel.errorDescription ?? "")
        }
        imageView.image = viewModel.image
        primaryLabel.text = viewModel.primaryText
        secondaryLabel.text = viewModel.secondaryText
    }
}
