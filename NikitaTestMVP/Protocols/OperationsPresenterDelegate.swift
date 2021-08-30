//
//  OperationsPresenterDelegate.swift
//  NikitaTestMVP
//
//  Created by Nikita Koniukh on 30/08/2021.
//

import Foundation

protocol OperationsPresenterDelegate {
    func presentOperations(operations: [Operation])
    func getSearchResults(operations: [Operation]) 
}
