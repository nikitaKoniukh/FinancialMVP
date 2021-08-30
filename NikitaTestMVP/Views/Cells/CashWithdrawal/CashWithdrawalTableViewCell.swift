//
//  CashWithdrawalTableViewCell.swift
//  NikitaTestMVP
//
//  Created by Nikita Koniukh on 30/08/2021.
//

import UIKit

class CashWithdrawalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var cellDelegate: CellSelectionDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(someAction))
        containerView.addGestureRecognizer(gesture)
    }
    
    @objc private func someAction(sender:UITapGestureRecognizer){
        guard let index = indexPath?.row else { return }
        cellDelegate?.pressButton(index: index)
    }
    
    
    func configureCell(operation: Operation, indexPath: IndexPath) {
        amountLabel.text = String(operation.amount)
        sourceLabel.text = operation.source
        addresLabel.text = operation.address
        self.indexPath = indexPath
    }
    
}
