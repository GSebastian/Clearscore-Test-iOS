//
//  ScoreViewModel.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 22/07/2021.
//

import Foundation

class ScoreViewModel {
    
    let scoreIntroText: String
    let score: Int
    let scoreText:  String
    let maxScore: Int
    let maxScoreText: String
    let scoreStatusText: String
    var animationCompletionHandler: (() -> Void)?
    
    init(scoreIntroText: String,
         score: Int,
         scoreText:  String,
         maxScore: Int,
         maxScoreText: String,
         scoreStatusText: String,
         animationCompletionHandler: (() -> Void)? = nil) {
        
        self.scoreIntroText = scoreIntroText
        self.score = score
        self.scoreText = scoreText
        self.maxScore = maxScore
        self.maxScoreText = maxScoreText
        self.scoreStatusText = scoreStatusText
        self.animationCompletionHandler = animationCompletionHandler
    }
    
    func animationCompleted() {
        animationCompletionHandler?()
    }
}
