//
//  FinalCompound.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/9/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class FinalCompound {
    
    var value : Double
    var unit : CompoundUnits
    
    init(value : Double , unit : CompoundUnits) {
        self.value = value
        self.unit = unit
    }
    
    func getValue() -> Double {
        return value
    }
    func getUnit() -> CompoundUnits{
        return unit
    }
}
