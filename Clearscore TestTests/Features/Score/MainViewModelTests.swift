//
//  MainViewModelTests.swift
//  Clearscore TestTests
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

@testable import Clearscore_Test

import XCTest

class MainViewModelTests: XCTestCase {
    
    func test_handlersCalled_whenAppropriate() {
        var successHandlerCounter = 0
        var failureHandlerCounter = 0
        
        let mockCreditService = MockCreditService()
        mockCreditService.response = .defaultStub
        
        let sut = MainViewModel(creditService: mockCreditService)
        sut.creditSuccessHandler = { _, _ in
            successHandlerCounter += 1
        }
        sut.creditFailureHandler = { _, _ in
            failureHandlerCounter += 1
        }
        
        sut.viewDidLoad()
        
        XCTAssertEqual(successHandlerCounter, 1)
        XCTAssertEqual(failureHandlerCounter, 0)
        
        sut.fetchScore()
        
        XCTAssertEqual(successHandlerCounter, 2)
        XCTAssertEqual(failureHandlerCounter, 0)
        
        mockCreditService.response = nil
        mockCreditService.error = MVVMError.initFromStoryboard
        
        sut.viewDidLoad()
        
        XCTAssertEqual(successHandlerCounter, 2)
        XCTAssertEqual(failureHandlerCounter, 1)
        
        sut.fetchScore()
        
        XCTAssertEqual(successHandlerCounter, 2)
        XCTAssertEqual(failureHandlerCounter, 2)
    }
    
    func test_successHandlerCalled_withCorrectViewModel() {
        let mockCreditService = MockCreditService()
        mockCreditService.response = .defaultStub
        
        var capturedScoreViewModel: ScoreViewModel!
        var capturedButtonText: String!
        
        let sut = MainViewModel(creditService: mockCreditService)
        sut.creditSuccessHandler = { scoreViewModel, buttonText in
            capturedScoreViewModel = scoreViewModel
            capturedButtonText = buttonText
        }
        
        sut.viewDidLoad()
        
        XCTAssertEqual(capturedScoreViewModel.maxScore, 5)
        XCTAssertEqual(capturedScoreViewModel.score, 1)
        XCTAssertEqual(capturedScoreViewModel.scoreStatusText, "Looking bright")
        // Note for interviewer: Skipping some properties for brevity
        XCTAssertEqual(capturedButtonText, "Find out more")
    }
    
    // Note for interviewer: failure handler test skipped, would have one in production
}
