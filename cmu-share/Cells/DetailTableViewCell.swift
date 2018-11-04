//
//  DetailTableViewCell.swift
//  cmu-share
//
//  Created by Bethany Huang on 11/1/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var joinerName: UILabel!
    
    @IBOutlet weak var foodItem1: UILabel!
    @IBOutlet weak var quantity1: UILabel!
    @IBOutlet weak var size1: UILabel!
    
    @IBOutlet weak var foodItem2: UILabel!
    @IBOutlet weak var quantity2: UILabel!
    @IBOutlet weak var size2: UILabel!
    
    @IBOutlet weak var phone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
