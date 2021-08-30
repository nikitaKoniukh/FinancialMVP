//
//  DetailsViewController.swift
//  NikitaTestMVP
//
//  Created by Nikita Koniukh on 30/08/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var idLabel: UILabel!
    
    var id: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    private func initialization() {
        // navigation controller
        title = "Operation"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
       
        if let idString = id {
            idLabel.text = "Operation id: \(idString)"
        }
    }

}
