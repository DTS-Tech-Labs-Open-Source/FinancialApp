//
//  SavedHistory.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/9/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class SavedHistory {
    let type: String
    let icon: UIImage
    let comutation: String
    
    init(type: String, icon: UIImage, comutation: String) {
        self.type = type
        self.icon = icon
        self.comutation = comutation
    }
    
    func getHistoryType() -> String {
        return type
    }
    
    func getHistoryIcon() -> UIImage {
        return icon
    }
    
    func getHistoryComputation() -> String {
        return comutation
    }
}

