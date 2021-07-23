//
//  ViewController.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Combine
import UIKit

class ViewController: UIViewController {
    
    var cancellable: AnyCancellable?
    
    @IBOutlet weak var contentWrapperView: UIStackView!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scoreView: ScoreView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cancellable = CreditService.getCreditData().sink { completion in
            print("Completed")
        } receiveValue: { [weak self] response in
            guard let self = self else { return }
                        
            let scoreTextWithPlaceholder = NSLocalizedString("scoreView.scoreFormattable", comment: "")
            let formattedScoreText = String(format: scoreTextWithPlaceholder, response.creditReportInfo.score)
            
            let maxScoreTextWithPlaceholder = NSLocalizedString("scoreView.maxScoreFormattable", comment: "")
            let formattedMaxScoreText = String(format: maxScoreTextWithPlaceholder, response.creditReportInfo.maxScoreValue)
            
            let viewModel = ScoreViewModel(
                scoreIntroText: NSLocalizedString("scoreView.intro", comment: ""),
                score: response.creditReportInfo.score,
                scoreText: formattedScoreText,
                maxScore: response.creditReportInfo.maxScoreValue,
                maxScoreText: formattedMaxScoreText,
                scoreStatusText: NSLocalizedString("scoreView.status.bright", comment: ""))
            
            self.scoreView.viewModel = viewModel
            
            self.contentWrapperView.addArrangedSubview(self.stackView)

            self.scoreView.animationCompletionHandler = { [unowned self] in
                UIView.animate(withDuration: 0.3) {
                    self.button.isHidden = false
                    self.button.layoutIfNeeded()
                }
            }
        }
    }
}
