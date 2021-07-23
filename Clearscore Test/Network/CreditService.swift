//
//  CreditService.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Combine
import Foundation

class CreditService: CreditServiceProtocol {
    
    func getCreditData() -> AnyPublisher<CreditResponse, Error> {
        // Note for interviewer:  Force-unwrapping here as the string is hardcoded.
        // In production, if this was a string built from multiple parts (e.g.
        // different environments), then I'd probably guard and raise a specific
        // error for malformed URLs.
        let url = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: CreditResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
