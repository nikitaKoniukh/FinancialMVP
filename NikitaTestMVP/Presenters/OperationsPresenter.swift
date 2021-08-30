//
//  Presenter.swift
//  NikitaTestMVP
//
//  Created by Nikita Koniukh on 30/08/2021.
//

import UIKit

class OperationsPresenter {
    
    typealias PresenterDelegate = OperationsPresenterDelegate & UIViewController
    
    weak var presenterDelegate: PresenterDelegate?
    
    func getOperationsFromJson() {
        
        guard let path = Bundle.main.path(forResource: "operations", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let operationsResult = try JSONDecoder().decode(Operations.self, from: jsonData)
            self.presenterDelegate?.presentOperations(operations: operationsResult.operations)
        } catch  {
            print("ERROR", error)
        }
    }
    
    func getSearchResults(operations op: [Operation], searchText: String) {
        
        var filteredOperations = Set<Operation>()
        let lowSearchText = searchText.lowercased()
        
        for element in op {
            if let operationDesc = element.operationDesc {
                if operationDesc.lowercased().contains(lowSearchText){
                    filteredOperations.insert(element)
                }
            }
            
            if let address = element.address {
                if address.lowercased().contains(lowSearchText){
                    filteredOperations.insert(element)
                }
            }
            
            if let operationDesc = element.operationDesc {
                if operationDesc.lowercased().contains(lowSearchText){
                    filteredOperations.insert(element)
                }
            }
            
            
            if element.operationType.lowercased().contains(lowSearchText){
                filteredOperations.insert(element)
            }
            
            
            if  String(element.amount).lowercased().contains(lowSearchText){
                filteredOperations.insert(element)
               
            }
           
        }
        self.presenterDelegate?.getSearchResults(operations:Array(filteredOperations))
        
        if searchText == "" {
            self.presenterDelegate?.getSearchResults(operations: [Operation]())
        }
        
        
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        presenterDelegate = delegate
    }
    
}
