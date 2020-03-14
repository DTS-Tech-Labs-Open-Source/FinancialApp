//
//  FinalMortgage.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class FinalMortgage {
    
    var value : Double
    var unit : MortgageUnits
    
    init(value : Double , unit : MortgageUnits) {
        self.value = value
        self.unit = unit
    }
    
    func getValue() -> Double {
        return value
    }
    func getUnit() -> MortgageUnits{
        return unit
    }
}
