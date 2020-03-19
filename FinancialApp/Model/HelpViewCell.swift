//
//  HelpViewCell.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/17/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class HelpViewCell: UITableViewCell {

    
    @IBOutlet weak var helpImageView: UIImageView!
    
    @IBOutlet weak var helpTitleText: UILabel!
    
    @IBOutlet weak var helpDiscripText: UILabel!
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
       }
}
