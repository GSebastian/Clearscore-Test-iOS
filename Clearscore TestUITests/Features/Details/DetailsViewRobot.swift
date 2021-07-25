//
//  DetailsViewRobot.swift
//  Clearscore TestUITests
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import XCTest

struct DetailsViewRobot: BaseRobotProtocol {
    
    // MARK: - Elements
    
    var subtitleText: XCUIElement { app.staticTexts["Here are more details from your credit report"] }
    
    // MARK: - Actions
    
    // MARK: - Checks
    
    @discardableResult
    func checkAllLabelsExist() -> Self {
        XCTAssertTrue(subtitleText.exists)
        
        return self
    }
}
