//
//  ScoreViewModel.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 22/07/2021.
//

import Foundation

class ScoreViewModel {
    
    var scoreIntroText: String
    var score: Int
    var scoreText:  String
    var maxScore: Int
    var maxScoreText: String
    var scoreStatusText: String
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
