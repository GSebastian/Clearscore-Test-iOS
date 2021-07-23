//
//  MockCreditService.swift
//  Clearscore TestTests
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

@testable import Clearscore_Test

import Combine

class MockCreditService: CreditServiceProtocol {
    
    var error: Error?
    var response: CreditResponse?
    
    func getCreditData() -> AnyPublisher<CreditResponse, Error> {
        if let error = error {
            return Fail(outputType: CreditResponse.self, failure: error).eraseToAnyPublisher()
        } else if let response = response {
            return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
        } else {
            preconditionFailure("Mock is missing both response and error.")
        }
    }
}
