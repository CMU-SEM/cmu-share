//
//  joinOrderController.swift
//  cmu-share
//
//  Created by Anup Ahuje on 10/18/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import UIKit
import Firebase

class joinOrderController: UIViewController {

    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var foodItemName1: UITextField!
    @IBOutlet weak var quantity1: UITextField!
    @IBOutlet weak var size1: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    @IBOutlet weak var secondViewWrapper: UIView!
    @IBOutlet weak var foodItemName2: UITextField!
    @IBOutlet weak var quantity2: UITextField!
    @IBOutlet weak var size2: UITextField!
    
    @IBOutlet weak var addMoreBtn: UIButton!
    
    var ref: DatabaseReference!
    var displayName: String!
    var orderId: String! // order id to be joined
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "joinToFeedSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViewWrapper(viewWrapper: self.viewWrapper);
        styleViewWrapper(viewWrapper: self.secondViewWrapper);
        self.secondViewWrapper.isHidden = true;
    }
    
    @IBAction func onClickAddMoreItem(_ sender: Any) {
        self.secondViewWrapper.isHidden = false;
        self.addMoreBtn.isEnabled = false;
        self.addMoreBtn.backgroundColor = UIColor.lightGray;
        self.addMoreBtn.titleLabel!.textColor = UIColor.white;
    }
    
    func styleViewWrapper(viewWrapper: UIView) {
        viewWrapper.layer.borderColor = UIColor.lightGray.cgColor;
        viewWrapper.layer.borderWidth = 0.3;
        viewWrapper.layer.cornerRadius = 5;
        
        viewWrapper.layer.shadowColor = UIColor.lightGray.cgColor
        viewWrapper.layer.shadowOpacity = 0.8
        viewWrapper.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewWrapper.layer.shadowRadius = 4
    }
}
