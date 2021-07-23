//
//  CreditServiceProtocol.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 23/07/2021.
//

import Combine

protocol CreditServiceProtocol {
    
    func getCreditData() -> AnyPublisher<CreditResponse, Error>
}
