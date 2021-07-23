//
//  MainViewModel.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import Combine
import Foundation

class MainViewModel {

    // MARK: - Properties
    
    var navigationTitle = NSLocalizedString("mainViewController.navigation.title", comment: "")
    var creditSuccessHandler: ((ScoreViewModel, String) -> Void)?
    var creditFailureHandler: ((String, String) -> Void)?
    
    private var creditService: CreditServiceProtocol
    private var cancellable: AnyCancellable?

    // MARK: - Init
    
    init(creditService: CreditServiceProtocol = CreditService()) {
        self.creditService = creditService
    }
    
    // MARK: - VC Lifecycle
    
    func viewDidLoad() {
        fetchScore()
    }
    
    func fetchScore() {
        self.cancellable = creditService.getCreditData().sink { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .failure:
                let failureViewConfig = self.failureViewConfiguration()
                self.creditFailureHandler?(failureViewConfig.description, failureViewConfig.buttonTitle)
            default:
                break
            }
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            
            let successViewConfig = self.successViewConfiguration(fromResponse: response)
            self.creditSuccessHandler?(successViewConfig.scoreViewModel, successViewConfig.buttonTitle)
        }
    }
    
    private func successViewConfiguration(
        fromResponse response: CreditResponse) -> (scoreViewModel: ScoreViewModel, buttonTitle: String) {
        
        let scoreTextWithPlaceholder =
            NSLocalizedString("scoreView.scoreFormattable", comment: "")
        let formattedScoreText =
            String(format: scoreTextWithPlaceholder, response.creditReportInfo.score)

        let maxScoreTextWithPlaceholder =
            NSLocalizedString("scoreView.maxScoreFormattable", comment: "")
        let formattedMaxScoreText =
            String(format: maxScoreTextWithPlaceholder, response.creditReportInfo.maxScoreValue)

        let viewModel = ScoreViewModel(
            scoreIntroText: NSLocalizedString("scoreView.intro", comment: ""),
            score: response.creditReportInfo.score,
            scoreText: formattedScoreText,
            maxScore: response.creditReportInfo.maxScoreValue,
            maxScoreText: formattedMaxScoreText,
            scoreStatusText: NSLocalizedString("scoreView.status.bright", comment: ""))

        let buttonText = NSLocalizedString("mainViewController.successView.detailButton", comment: "")

        return (viewModel, buttonText)
    }
    
    private func failureViewConfiguration() -> (description: String, buttonTitle: String) {
        (
            NSLocalizedString("mainViewController.failureView.description", comment: ""),
            NSLocalizedString("mainViewController.failureView.button", comment: "")
        )
    }
}
