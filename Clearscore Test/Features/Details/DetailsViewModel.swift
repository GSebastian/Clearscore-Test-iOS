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
    
    // MARK: - Methods
    
    private static func cardViewModels(fromResponse creditResponse: CreditResponse) -> [CardViewModel] {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.locale = .current
        formatter.numberStyle = .currency
        formatter.currencyCode = "GBP"
        
        func cardViewModel(imageName: String,
                           primaryTextKey: String,
                           secondaryTextKey: String,
                           secondaryTextArguments: CVarArg) -> CardViewModel {
            
            let secondaryWithPlaceholders =
                NSLocalizedString(secondaryTextKey, comment: "")
            let secondaryText = String(
                format: secondaryWithPlaceholders,
                secondaryTextArguments)
            return CardViewModel(
                image: UIImage(systemName: imageName)!,
                primaryText: NSLocalizedString(primaryTextKey, comment: ""),
                secondaryText: secondaryText)
        }
        
        let card1SecondaryNumber = creditResponse.creditReportInfo.currentShortTermCreditLimit
        let card1SecondaryNumberFormatted = formatter.string(
            from: NSNumber(value: card1SecondaryNumber)) ?? "\(card1SecondaryNumber)"
        
        let shortTermCreditLimitViewModel = cardViewModel(
            imageName: "dollarsign.circle",
            primaryTextKey: "detailsViewController.card1.primary",
            secondaryTextKey: "detailsViewController.card1.secondary",
            secondaryTextArguments: card1SecondaryNumberFormatted)
        
        let creditUtilisationViewModel = cardViewModel(
            imageName: "banknote",
            primaryTextKey: "detailsViewController.card2.primary",
            secondaryTextKey: "detailsViewController.card2.secondary",
            secondaryTextArguments: creditResponse.creditReportInfo.currentShortTermCreditUtilisation)

        let card3SecondaryNumber =
            creditResponse.creditReportInfo.currentShortTermDebt
        let card3SecondaryNumberFormatted =
            formatter.string(from: NSNumber(value: card3SecondaryNumber)) ?? "\(card3SecondaryNumber)"
        
        let shortTermDebtViewModel = cardViewModel(
            imageName: "clock",
            primaryTextKey: "detailsViewController.card3.primary",
            secondaryTextKey: "detailsViewController.card3.secondary",
            secondaryTextArguments: card3SecondaryNumberFormatted)

        let nextReportViewModel = cardViewModel(
            imageName: "doc.text",
            primaryTextKey: "detailsViewController.card4.primary",
            secondaryTextKey: "detailsViewController.card4.secondary",
            secondaryTextArguments: creditResponse.creditReportInfo.daysUntilNextReport)
        
        return [shortTermCreditLimitViewModel, creditUtilisationViewModel, shortTermDebtViewModel, nextReportViewModel]
    }
}
