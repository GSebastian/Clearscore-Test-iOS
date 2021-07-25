//
//  MainViewTests.swift
//  Clearscore TestUITests
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import XCTest

// Notes for interviewer: These tests are quite basic. In production I would've stubbed the network responses,
// so that I could test all view states.
//
// I find this Robots abstraction really useful when writing UI tests, as it encourages whoever is writing them to
// think more in terms of accessibility rather than testing out scenarios which can easily be picked up by unit tests.

class MainViewTests: XCTestCase {
    
    func test_mainViewController_isAccessible() {
        application.launch()
        
        MainViewRobot()
            .checkAllLabelsExist()
            .tapDetailButton()
            .checkAllLabelsExist()
    }
}
