//
//  DetailsViewController.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet var cardViews: [UIView]!
    // MARK: - Properties
    
    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardViews.forEach { cardView in
            cardView.layer.cornerRadius = 8
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.shadowOffset = .zero
            cardView.layer.shadowRadius = 8
        }
    }
}
