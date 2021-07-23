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
    
    var creditSuccessHandler: ((ScoreViewModel, String) -> Void)?
    var creditFailureHandler: (() -> Void)?
    
    private var cancellable: AnyCancellable?

    // MARK: - VC Lifecycle
    
    func viewDidLoad() {
        fetchScore()
    }
    
    func fetchScore() {
        self.cancellable = CreditService.getCreditData().sink { completion in
            
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            
            let successViewConfig = self.successViewConfiguration(fromResponse: response)
            self.creditSuccessHandler?(successViewConfig.0, successViewConfig.1)
        }
    }
    
    private func successViewConfiguration(fromResponse response: CreditResponse) -> (ScoreViewModel, String) {
        
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

        let buttonText = NSLocalizedString("mainViewController.successView.button", comment: "")

        return (viewModel, buttonText)
    }
}
