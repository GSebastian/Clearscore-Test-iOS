//
//  ScoreViewModel.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 22/07/2021.
//

import Foundation

struct ScoreViewModel {
    
    var scoreIntroText: String
    var score: Int
    var scoreText:  String
    var maxScore: Int
    var maxScoreText: String
    var scoreStatusText: String
}

extension ScoreViewModel {
    
    static var preview = ScoreViewModel(
        scoreIntroText: "(your credit score is)",
        score: 499,
        scoreText: "(499)",
        maxScore: 700,
        maxScoreText: "(out of 700)",
        scoreStatusText: "(Looking bright)")
}
