//
//  DistanceCell.swift
//  Yelp
//
//  Created by Quoc Huy on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DistanceCellDelegate {
    @objc optional func distanceCell(distanceCell: DistanceCell, didChangeValue value: Bool)
}

class DistanceCell: UITableViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var distanceImage: UIImageView!
    
    weak var delegate: DistanceCellDelegate?
    
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
        
        delegate?.distanceCell!(distanceCell: self, didChangeValue: pressButton)
        
        pressButton = false
        
    }
    
}
