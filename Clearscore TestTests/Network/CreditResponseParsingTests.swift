//
//  CreditResponseParsingTests.swift
//  Clearscore TestTests
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import XCTest

@testable import Clearscore_Test

class CreditResponseParsingTests: XCTestCase {

    func test_normalResponse() throws {
        // We're happy to unwrap here - if it fails, there's something wrong
        // with our test setup, not a genuine failure
        let responseAsData = data(from: RawResponses.normal.rawValue)!
        
        let sut: CreditResponse
        do {
            sut = try JSONDecoder().decode(CreditResponse.self, from: responseAsData)
        } catch {
            XCTFail("Unexpected failure to parse")
            throw error
        }
        
        XCTAssertEqual(sut.accountIDVStatus, .pass)
        // Note for the interviewer: ... assert other properties below. Or,
        // better yet, I made the models Equatable, so we could even add some
        // expected objects below (just as we did with the raw responses), and
        // simply assert equality. This should save on boilerplace, making the
        // tests easier to read.
    }
    
    // Note for the interviewer: ... more tests below, checking for edge cases
    // such as mispelled/missing/null properties.
    
    // MARK: - Utils
    
    private func data(from string: String) -> Data! {
        string.data(using: .utf16)
    }
    
    enum RawResponses: String {
        case normal = """
            {
               "accountIDVStatus":"PASS",
               "creditReportInfo":{
                  "score":514,
                  "scoreBand":4,
                  "clientRef":"CS-SED-655426-708782",
                  "status":"MATCH",
                  "maxScoreValue":700,
                  "minScoreValue":0,
                  "monthsSinceLastDefaulted":-1,
                  "hasEverDefaulted":false,
                  "monthsSinceLastDelinquent":1,
                  "hasEverBeenDelinquent":true,
                  "percentageCreditUsed":44,
                  "percentageCreditUsedDirectionFlag":1,
                  "changedScore":0,
                  "currentShortTermDebt":13758,
                  "currentShortTermNonPromotionalDebt":13758,
                  "currentShortTermCreditLimit":30600,
                  "currentShortTermCreditUtilisation":44,
                  "changeInShortTermDebt":549,
                  "currentLongTermDebt":24682,
                  "currentLongTermNonPromotionalDebt":24682,
                  "currentLongTermCreditLimit":null,
                  "currentLongTermCreditUtilisation":null,
                  "changeInLongTermDebt":-327,
                  "numPositiveScoreFactors":9,
                  "numNegativeScoreFactors":0,
                  "equifaxScoreBand":4,
                  "equifaxScoreBandDescription":"Excellent",
                  "daysUntilNextReport":9
               },
               "dashboardStatus":"PASS",
               "personaType":"INEXPERIENCED",
               "coachingSummary":{
                  "activeTodo":false,
                  "activeChat":true,
                  "numberOfTodoItems":0,
                  "numberOfCompletedTodoItems":0,
                  "selected":true
               },
               "augmentedCreditScore":null
            }
            """
    }
}
