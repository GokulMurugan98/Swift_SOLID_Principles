//
//  ModelClass.swift
//  SOLIDprinciples
//
//  Created by Gokul Murugan on 26/04/24.
//

import Foundation

struct ModelClass: Codable {
    let status: String
    let data: [User]
    let message: String
}

// MARK: - Datum
struct User: Codable {
    let id: Int
    let employee_name: String
    let employee_salary, employee_age: Int
    let profile_image: String
}

struct SingleUser: Codable {
    let status: String
    let data: User
    let message: String
}


