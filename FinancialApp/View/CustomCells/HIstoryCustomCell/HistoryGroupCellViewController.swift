//
//  HistoryCellViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/3/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit


class HistoryGroupCellViewController: UITableViewCell {
    
    @IBOutlet weak var countId: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitel: UILabel!
    @IBOutlet weak var cellDiscription: UILabel!
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
//    }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonInit(_ imageName : UIImage , titel :String , id: String , discription: String) -> Void {
        cellImage.image = imageName
        countId.text = id
        cellTitel.text = titel
        cellDiscription.text = discription
        
        // Card(cell) styles
        self.isUserInteractionEnabled = false
        self.contentView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00)
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00).cgColor
        self.contentView.layer.masksToBounds = false
    }
}
