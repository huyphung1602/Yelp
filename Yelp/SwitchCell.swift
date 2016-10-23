//
//  SwitchCell.swift
//  Yelp
//
//  Created by Quoc Huy on 10/18/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}


class SwitchCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var borderView: UIView!
    
    
    weak var delegate: SwitchCellDelegate?
    
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
        print("switch changed to \(sender.isOn)")
        
        delegate?.switchCell!(switchCell: self, didChangeValue: sender.isOn)
        
    }
    
    
}
