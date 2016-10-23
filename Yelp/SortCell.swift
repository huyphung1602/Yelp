//
//  SortCell.swift
//  Yelp
//
//  Created by Quoc Huy on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SortCellDelegate {
    @objc optional func sortCell(sortCell: SortCell, didChangeValue value: Bool)
}


class SortCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var sortImage: UIImageView!
    
    weak var delegate: SortCellDelegate?
    
    var pressButton = false
    
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
    
    @IBAction func onPress(_ sender: AnyObject) {
        print("Sort button has been pressed")
        
        pressButton = true
        
        delegate?.sortCell!(sortCell: self, didChangeValue: pressButton)
        
        pressButton = false
        
    }
    

}
