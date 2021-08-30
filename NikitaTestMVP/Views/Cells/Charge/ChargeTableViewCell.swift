//
//  ChargeTableViewCell.swift
//  NikitaTestMVP
//
//  Created by Nikita Koniukh on 30/08/2021.
//

import UIKit

class ChargeTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var operationDescLabel: UILabel!
    
    var cellDelegate: CellSelectionDelegate?
    var indexPath: IndexPath?
    
    func configureCell(operation: Operation, indexPath: IndexPath) {
        amountLabel.text = "$\(String(operation.amount))" 
        operationDescLabel.text = operation.operationDesc
        self.indexPath = indexPath
    }
    
    @IBAction func infoButtonWasPressed(_ sender: UIButton) {
        guard let index = indexPath?.row else { return }
        cellDelegate?.pressButton(index: index)
    }
}
