//
//  DetailsViewModel.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import Foundation

class DetailsViewModel {
    
    // MARK: - Properties
    
    let cardViewModels: [CardViewModel]
    let primaryText: String
    let secondaryText: String
    
    // MARK: - Init
    
    init(creditResponse: CreditResponse) {
        let cardViewModels: [CardViewModel] = []
        
//        let creditLimitViewModel = CardViewModel(
//            image: .init(systemName: ),
//            primaryText: <#T##String#>,
//            secondaryText: <#T##String#>)
//
//        let creditUtilisationViewModel = CardViewModel(
//            image: <#T##UIImage#>,
//            primaryText: <#T##String#>,
//            secondaryText: <#T##String#>)
//
//        let shortTermCreditLimitViewModel = CardViewModel(
//            image: <#T##UIImage#>,
//            primaryText: <#T##String#>,
//            secondaryText: <#T##String#>)
//
//        let nextReportViewModel = CardViewModel(
//            image: <#T##UIImage#>,
//            primaryText: <#T##String#>,
//            secondaryText: <#T##String#>)
        
        self.cardViewModels = cardViewModels
        
        self.primaryText = NSLocalizedString("", comment: "")
        self.secondaryText = NSLocalizedString("", comment: "")
    }
    
    // MARK: - VC Lifecycle
    
    func viewDidLoad() {
        
    }
    
    // MARK: - Methods
}
