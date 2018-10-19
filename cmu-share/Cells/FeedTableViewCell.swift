

//
//  FeedTableViewCell.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 10/16/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

protocol FeedCellDelegate: class {
    func didTapJoin(_ sender: FeedTableViewCell)
}
class FeedTableViewCell: UITableViewCell {
    weak var delegate: FeedCellDelegate?
    
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var numOfPeople: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    
    @IBOutlet weak var joinButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func joinAction(_ sender: UIButton) {
        delegate?.didTapJoin(self)
    }
}
