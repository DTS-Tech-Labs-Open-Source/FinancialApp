//
//  SaveHistoryViewCellController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class SaveHistoryViewCellController: UITableViewCell {
    
    @IBOutlet weak var cellId: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitel: UILabel!
    @IBOutlet weak var cellDiscription: UILabel!
    
    
    override func layoutSubviews() {
           super.layoutSubviews()
           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
       }
}
