//
//  MainViewRobot.swift
//  Clearscore TestUITests
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import XCTest

struct MainViewRobot: BaseRobotProtocol {
    
    // MARK: - Elements
    
    var introText: XCUIElement { app.staticTexts["Your credit score is"] }
    var scoreText: XCUIElement { app.staticTexts["514"] }
    var maxScoreText: XCUIElement { app.staticTexts["out of 700"] }
    var scoreStatusText: XCUIElement { app.staticTexts["Looking bright"] }
    
    var detailButton: XCUIElement { app.buttons["Find out more"] }
    
    // MARK: - Actions
    
    @discardableResult
    func tapDetailButton() -> DetailsViewRobot {
        detailButton.tap()
        return DetailsViewRobot()
    }
    
    // MARK: - Checks
    
    @discardableResult
    func checkAllLabelsExist() -> Self {
        XCTAssertTrue(introText.exists)
        XCTAssertTrue(scoreText.exists)
        XCTAssertTrue(maxScoreText.exists)
        XCTAssertTrue(scoreStatusText.exists)
        
        XCTAssertTrue(detailButton.waitForExistence(timeout: 5))
        XCTAssertTrue(detailButton.isHittable)
        
        return self
    }
}
