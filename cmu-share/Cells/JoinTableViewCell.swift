//
//  JoinTableViewCell.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/20/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class JoinTableViewCell: UITableViewCell {
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var numOfPeople: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
