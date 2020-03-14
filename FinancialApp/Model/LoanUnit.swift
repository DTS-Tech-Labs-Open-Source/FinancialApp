//
//  LoanUnit.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class LoanUnit {
    
    var tagValue : Int
    var textField : UITextField
    var unit : LoanUnits
    
    init(tagValue : Int , textField : UITextField , unit : LoanUnits) {
        self.tagValue = tagValue
        self.textField = textField
        self.unit = unit
    }
    
    func getTagValue() -> Int {
        return tagValue
    }
    
    func getTextValue() -> UITextField {
        return textField
    }
    
    func getUnit() -> LoanUnits{
        return unit
    }
}

