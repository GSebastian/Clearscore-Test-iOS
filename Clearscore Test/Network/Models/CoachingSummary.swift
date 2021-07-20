//
//  CoachingSummary.swift
//  Clearscore Test
//
//  Created by Sebastian Ghetu on 20/07/2021.
//

import Foundation

struct CoachingSummary: Codable, Equatable {
    let activeTodo: Bool?
    let activeChat: Bool?
    let numberOfTodoItems: Int?
    let numberOfCompletedTodoItems: Int?
    let selected: Bool?
}
