//
//  Operation.swift
//  NikitaTestMVP
//
//  Created by Nikita Koniukh on 30/08/2021.
//

import Foundation

struct Operation: Codable, Hashable {
    var operationType: String
    var amount: Double
    var source: String?
    var address: String?
    var operationId: Int
    var operationDesc: String?
}

struct Operations: Codable {
    var operations: [Operation]
}

enum OperationType: String {
    case cashWithrawal = "CASH_WITHDRAWAL"
    case charge = "CHARGE"
    case savingWithrawal = "SAVING_WITHDRAWAL"
    case refund = "REFUND"
    case salary = "SALARY"
}
