//
//  ScoreViewModelTests.swift
//  Clearscore TestTests
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import XCTest

@testable import Clearscore_Test

class ScoreViewModelTests: XCTestCase {
    
    func test_init() {
        var animationCompletionHandlerCalled = false
            
        let sut = ScoreViewModel(
            scoreIntroText: "a",
            score: 123,
            scoreText: "b",
            maxScore: 456,
            maxScoreText: "c",
            scoreStatusText: "d") {
            
            animationCompletionHandlerCalled = true
        }
        
        XCTAssertEqual(sut.scoreIntroText, "a")
        XCTAssertEqual(sut.score, 123)
        XCTAssertEqual(sut.scoreText, "b")
        XCTAssertEqual(sut.maxScore, 456)
        XCTAssertEqual(sut.maxScoreText, "c")
        XCTAssertEqual(sut.scoreStatusText, "d")
        
        sut.animationCompleted()
        
        XCTAssertTrue(animationCompletionHandlerCalled)
    }
}
