//
//  CreditResponse+Stub.swift
//  Clearscore TestTests
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

@testable import Clearscore_Test

extension CreditResponse {
    
    static var defaultStub = CreditResponse(
        accountIDVStatus: .pass,
        creditReportInfo: .init(
            score: 1,
            scoreBand: 2,
            clientRef: "clientRef",
            status: .match,
            maxScoreValue: 5,
            minScoreValue: 6,
            monthsSinceLastDefaulted: 7,
            hasEverDefaulted: false,
            monthsSinceLastDelinquent: 9,
            hasEverBeenDelinquent: true,
            percentageCreditUsed: 11,
            percentageCreditUsedDirectionFlag: 12,
            changedScore: 13,
            currentShortTermDebt: 14,
            currentShortTermNonPromotionalDebt: 15,
            currentShortTermCreditLimit: 16,
            currentShortTermCreditUtilisation: 17,
            changeInShortTermDebt: 18,
            currentLongTermDebt: 19,
            currentLongTermNonPromotionalDebt: 20,
            changeInLongTermDebt: 21,
            numPositiveScoreFactors: 22,
            numNegativeScoreFactors: 23,
            equifaxScoreBand: 24,
            equifaxScoreBandDescription: "equifaxScoreBandDescription",
            daysUntilNextReport: 26),
        dashboardStatus: .pass,
        personaType: .inexperienced,
        coachingSummary: .init(
            activeTodo: false,
            activeChat: true,
            numberOfTodoItems: 3,
            numberOfCompletedTodoItems: 4,
            selected: false))
}
