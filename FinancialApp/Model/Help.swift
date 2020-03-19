//
//  Help.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/17/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class Help {
    let name: String
    let discription: NSMutableAttributedString
    let icon: UIImage
    
    init(name: String, discription: NSMutableAttributedString, icon: UIImage) {
        self.name = name
        self.discription = discription
        self.icon = icon
    }
    
    func getName() -> String {
        return name
    }
    
    func getIcon() -> UIImage {
        return icon
    }
    
    func getDiscription() -> NSMutableAttributedString {
        return discription
    }
}
