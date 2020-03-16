//
//  CurrencyRateUnit.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/15/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class CurrencyRateUnit{
    
    let countryCode: String
    let currencyValue: Double
    
    

    init(code : String , value : Double) {
        self.countryCode = code
        self.currencyValue = value
    }
    
    
    func getCountryCode() -> String {
        return self.countryCode
    }
    
    func getCurrencyValue() -> Double {
        return self.currencyValue
    }
}
