//
//  FinalSaving.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class FinalSaving {
    
    var value : Double
    var unit : SavingUnits
    
    init(value : Double , unit : SavingUnits) {
        self.value = value
        self.unit = unit
    }
    
    func getValue() -> Double {
        return value
    }
    func getUnit() -> SavingUnits{
        return unit
    }
}
