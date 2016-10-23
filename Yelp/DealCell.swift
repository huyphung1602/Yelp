//
//  DealCell.swift
//  Yelp
//
//  Created by Quoc Huy on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealCellDelegate {
    @objc optional func dealCell(dealCell: DealCell, didChangeValue value: Bool)
}

class DealCell: UITableViewCell {

    @IBOutlet weak var DealLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var borderView: UIView!
    
    weak var delegate: DealCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        borderView.layer.borderColor = UIColor.gray.cgColor
        borderView.layer.borderWidth = 1
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSwitch(_ sender: AnyObject) {
        print("Deal switch changed to \(sender.isOn)")
        
        delegate?.dealCell!(dealCell: self, didChangeValue: sender.isOn)
    }
    
}
