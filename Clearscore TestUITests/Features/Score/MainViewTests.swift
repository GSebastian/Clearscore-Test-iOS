//
//  MainViewTests.swift
//  Clearscore TestUITests
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import XCTest

class MainViewTests: BaseUITest {
    
    func test_mainViewController_isAccessible() {
        application.launch()
        
        MainViewRobot()
            .checkAllLabelsExist()
    }
}
