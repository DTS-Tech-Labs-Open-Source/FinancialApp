//
//  CompoundUnit.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/9/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class CompoundUnit {
    
    var tagValue : Int
    var textField : UITextField
    var unit : CompoundUnits
    
    init(tagValue : Int , textField : UITextField , unit : CompoundUnits) {
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
    
    func getUnit() -> CompoundUnits{
        return unit
    }
}
