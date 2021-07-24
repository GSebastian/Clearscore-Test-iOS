//
//  DetailsViewModel.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import Foundation
import UIKit

class DetailsViewModel {
    
    // MARK: - Properties
    
    let cardViewModels: [CardViewModel]
    let primaryText: String
    let secondaryText: String
    
    // MARK: - Init
    
    init(creditResponse: CreditResponse) {
        self.cardViewModels = Self.cardViewModels(fromResponse: creditResponse)
        
        let primaryTextWithPlaceholders = NSLocalizedString("detailsViewController.titleFormattable", comment: "")
        self.primaryText = String(format: primaryTextWithPlaceholders, creditResponse.creditReportInfo.score)
        self.secondaryText = NSLocalizedString("detailsViewController.subtitle", comment: "")
    }
    
    // MARK: - VC Lifecycle
    
    func viewDidLoad() {
        
    }
    
    // MARK: - Methods
    
    private static func cardViewModels(fromResponse creditResponse: CreditResponse) -> [CardViewModel] {
        let card1SecondaryWithPlaceholders = NSLocalizedString("detailsViewController.card1.secondary", comment: "")
        let card1Secondary = String(format: card1SecondaryWithPlaceholders, creditResponse.creditReportInfo.currentShortTermDebt)
        let shortTermCreditLimitViewModel = CardViewModel(
            image: UIImage(systemName: "dollarsign.circle")!,
            primaryText: NSLocalizedString("detailsViewController.card1.primary", comment: ""),
            secondaryText: card1Secondary)

        let card2SecondaryWithPlaceholders = NSLocalizedString("detailsViewController.card2.secondary", comment: "")
        let card2Secondary = String(format: card2SecondaryWithPlaceholders, creditResponse.creditReportInfo.currentShortTermCreditUtilisation)
        let creditUtilisationViewModel = CardViewModel(
            image: UIImage(systemName: "banknote")!,
            primaryText: NSLocalizedString("detailsViewController.card2.primary", comment: ""),
            secondaryText: card2Secondary)

        let card3SecondaryWithPlaceholders = NSLocalizedString("detailsViewController.card3.secondary", comment: "")
        let card3Secondary = String(format: card3SecondaryWithPlaceholders, creditResponse.creditReportInfo.currentShortTermDebt)
        let shortTermDebtViewModel = CardViewModel(
            image: UIImage(systemName: "clock")!,
            primaryText: NSLocalizedString("detailsViewController.card3.primary", comment: ""),
            secondaryText: card3Secondary)

        let card4SecondaryWithPlaceholders = NSLocalizedString("detailsViewController.card3.secondary", comment: "")
        let card4Secondary = String(format: card4SecondaryWithPlaceholders, creditResponse.creditReportInfo.daysUntilNextReport)
        let nextReportViewModel = CardViewModel(
            image: UIImage(systemName: "doc.text")!,
            primaryText: NSLocalizedString("detailsViewController.card4.primary", comment: ""),
            secondaryText: card4Secondary)
        
        return [shortTermCreditLimitViewModel, creditUtilisationViewModel, shortTermDebtViewModel, nextReportViewModel]
    }
}
