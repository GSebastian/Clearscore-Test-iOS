//
//  CreditResponse.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Foundation

struct CreditResponse: Codable, Equatable {
    let accountIDVStatus: AccountIDVStatus?
    let creditReportInfo: CreditReportInfo?
    let dashboardStatus: DashboardStatus?
    let personaType: PersonaType?
    let coachingSummary: CoachingSummary?
    // Note for interviewer:  As explained in the README
    //    let augmentedCreditScore: AnyCodable?
}

// MARK: - Associated Enums

enum AccountIDVStatus: String, Codable, Equatable {
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

enum DashboardStatus: String, Codable, Equatable {
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

enum PersonaType: String, Codable, Equatable {
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
