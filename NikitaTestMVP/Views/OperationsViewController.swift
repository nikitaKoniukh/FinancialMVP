//
//  ViewController.swift
//  NikitaTestMVP
//
//  Created by Nikita Koniukh on 30/08/2021.
//

import UIKit

class OperationsViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private let operationsPresenter = OperationsPresenter()
    private var operations = [Operation]()
    private var filteredOperations = [Operation]()
    
    // MARK: - lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    private func initialization() {
        // navigation controller
        title = "Financial operations"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // search bar
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        // tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        // cells
        let cashCell = UINib(nibName: "CashWithdrawalTableViewCell", bundle: nil)
        tableView.register(cashCell, forCellReuseIdentifier: "cashCell")
        
        let chargeCell = UINib(nibName: "ChargeTableViewCell", bundle: nil)
        tableView.register(chargeCell, forCellReuseIdentifier: "chargeCell")
        
        let incomeCell = UINib(nibName: "IncomeTableViewCell", bundle: nil)
        tableView.register(incomeCell, forCellReuseIdentifier: "incomeCell")
        
        // presenter
        operationsPresenter.setViewDelegate(delegate: self)
        operationsPresenter.getOperationsFromJson()
    }
    
    func getSearchResults(operations: [Operation], searchText: String) {
      //  print(operations.contains{ $0.operationType == searchText })
        
        print(operations.enumerated().contains{ $0.element.operationType == searchText })
        
        
    }
}

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

extension OperationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredOperations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cashCell = tableView.dequeueReusableCell(withIdentifier: "cashCell", for: indexPath) as! CashWithdrawalTableViewCell
        let chargeCell = tableView.dequeueReusableCell(withIdentifier: "chargeCell", for: indexPath) as! ChargeTableViewCell
        let incomeCell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as! IncomeTableViewCell
        
        let operation = filteredOperations[indexPath.row]
        
        switch operation.operationType {
        case OperationType.cashWithrawal.rawValue:
            cashCell.configureCell(operation: operation, indexPath: indexPath)
            cashCell.cellDelegate = self
            return cashCell
        case OperationType.charge.rawValue:
            chargeCell.configureCell(operation: operation, indexPath: indexPath)
            chargeCell.cellDelegate = self
            return chargeCell
        default:
            incomeCell.configureCell(operation: operation, indexPath: indexPath)
            incomeCell.cellDelegate = self
            return incomeCell
        }
    }
    
}

extension OperationsViewController: OperationsPresenterDelegate {
    func getSearchResults(operations: [Operation]) {
        self.filteredOperations = operations
        if operations.count == 0 {
            self.filteredOperations = self.operations
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentOperations(operations: [Operation]) {

        self.operations = operations
        self.filteredOperations = operations
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension OperationsViewController: CellSelectionDelegate {
    func pressButton(index: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsViewController
        detailsVC.id = String(operations[index].operationId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension OperationsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        operationsPresenter.getSearchResults(operations: operations, searchText: searchText)
       // tableView.reloadData()
    }
}

