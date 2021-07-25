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
    private weak var coordinatorDelegate: MainCoordinatorDelegate?
    private var cancellable: AnyCancellable?
    
    private var creditResponse: CreditResponse?

    // MARK: - Init
    
    init(creditService: CreditServiceProtocol = CreditService(),
         coordinatorDelegate: MainCoordinatorDelegate?) {
        self.creditService = creditService
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    // MARK: - VC Inputs
    
    func viewDidLoad() {
        fetchScore()
    }
    
    func scoreDetailButtonTapped() {
        // Note for interviewer: I like to use `preconditionFailure` for inconsistent states whenever I have good
        // automated testing coverage, as it guards against situations where a screen/element isn't performing its
        // basic functions.
        guard let creditResponse = self.creditResponse else {
            preconditionFailure("creditResponse needs to be non-nil in order for details to be displayed.")
        }
        coordinatorDelegate?.showDetail(creditResponse: creditResponse)
    }
    
    // MARK: - Methods
    
    func fetchScore() {
        self.cancellable = creditService.getCreditData().sink { [weak self] completion in
            guard let self = self else { return }
            
            switch completion {
            case .failure:
                self.creditResponse = nil
                
                let failureViewConfig = self.failureViewConfiguration()
                self.creditFailureHandler?(failureViewConfig.description, failureViewConfig.buttonTitle)
            default:
                break
            }
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
            
            self.creditResponse = response
            
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
