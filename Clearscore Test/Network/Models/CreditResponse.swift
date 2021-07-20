//
//  CreditResponse.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Foundation

struct CreditResponse: Codable {
    let accountIDVStatus: AccountIDVStatus?
    let creditReportInfo: CreditReportInfo?
    let dashboardStatus: DashboardStatus?
    let personaType: String?
    let coachingSummary: CoachingSummary?
    // As explained in the README
    //    let augmentedCreditScore: AnyCodable?
}

// MARK: - Associated Enums

enum AccountIDVStatus: String, Codable {
    case pass = "PASS"
    case unknown = "UNKNOWN"
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.singleValueContainer()
        let value = try valueContainer.decode(String.self)
        switch value {
        case "PASS":
            self = .pass
        default:
            self = .unknown
        }
    }
}

enum DashboardStatus: String, Codable {
    case pass = "PASS"
    case unknown = "UNKNOWN"
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.singleValueContainer()
        let value = try valueContainer.decode(String.self)
        switch value {
        case "PASS":
            self = .pass
        default:
            self = .unknown
        }
    }
}

enum PersonaType: String, Codable {
    case inexperienced = "INEXPERIENCED"
    case unknown = "UNKNOWN"
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.singleValueContainer()
        let value = try valueContainer.decode(String.self)
        switch value {
        case "INEXPERIENCED":
            self = .inexperienced
        default:
            self = .unknown
        }
    }
}
