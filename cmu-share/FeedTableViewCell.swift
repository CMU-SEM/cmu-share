//
//  FeedTableViewCell.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/16/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var viewWrapper: UIView!
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var numOfPeople: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
