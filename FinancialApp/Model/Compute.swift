//
//  Compute.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 2/27/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class Compute {
    
    let name : String
    let cellIcon : UIImage
    let cellColor : UIColor
    let cellId : String
    
    init(name : String , cellIcon: UIImage , cellColor: UIColor , cellId : String) {
        self.name = name
        self.cellColor = cellColor
        self.cellIcon = cellIcon
        self.cellId = cellId
    }
    
    func getname() -> String {
        return name
    }
    
    func getCellIcon() -> UIImage {
        return cellIcon
    }
    
    func getCellColor() -> UIColor {
        return cellColor
    }
    
    func getCellId() -> String {
        return cellId
    }
}
