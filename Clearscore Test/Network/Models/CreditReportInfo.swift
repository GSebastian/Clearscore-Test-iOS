//
//  CreditReportInfo.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Foundation

struct CreditReportInfo: Codable {
    let score: Int?
    let scoreBand: Int?
    let clientRef: String?
    let status: CreditReportInfoStatus?
    let maxScoreValue: Int?
    let minScoreValue: Int?
    let monthsSinceLastDefaulted: Int?
    let hasEverDefaulted: Bool?
    let monthsSinceLastDelinquent: Int?
    let hasEverBeenDelinquent: Bool?
    let percentageCreditUsed: Int?
    let percentageCreditUsedDirectionFlag: Int?
    let changedScore: Int?
    let currentShortTermDebt: Int?
    let currentShortTermNonPromotionalDebt: Int?
    let currentShortTermCreditLimit: Int?
    let currentShortTermCreditUtilisation: Int?
    let changeInShortTermDebt: Int?
    let currentLongTermDebt: Int?
    let currentLongTermNonPromotionalDebt: Int?
    // As explained in the README
    //    let currentLongTermCreditLimit: AnyCodable?
    //    let currentLongTermCreditUtilisation: AnyCodable?
    let changeInLongTermDebt: Int?
    let numPositiveScoreFactors: Int?
    let numNegativeScoreFactors: Int?
    let equifaxScoreBand: Int?
    let equifaxScoreBandDescription: String?
    let daysUntilNextReport: Int?
}

// MARK: - Associated Enums

enum CreditReportInfoStatus: String, Codable {
    case match = "MATCH"
    case unknown = "UNKNOWN"
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.singleValueContainer()
        let value = try valueContainer.decode(String.self)
        switch value {
        case "MATCH":
            self = .match
        default:
            self = .unknown
        }
    }
}
