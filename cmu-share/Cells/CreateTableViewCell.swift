//
//  CreateTableViewCell.swift
//  cmu-share
//
//  Created by Bethany Huang on 10/20/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit

protocol CreateCellDelegate: class {
    func didTapClose(_ sender: CreateTableViewCell)
}
class CreateTableViewCell: UITableViewCell {
    weak var delegate: CreateCellDelegate?
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var numOfPeople: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func closeAction(_ sender: UIButton) {
        delegate?.didTapClose(self)
    }
    
}
