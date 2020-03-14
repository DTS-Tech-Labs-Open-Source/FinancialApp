//
//  FinalLoan.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class FinalLoan {
    
    var value : Double
    var unit : LoanUnits
    
    init(value : Double , unit : LoanUnits) {
        self.value = value
        self.unit = unit
    }
    
    func getValue() -> Double {
        return value
    }
    func getUnit() -> LoanUnits{
        return unit
    }
}
