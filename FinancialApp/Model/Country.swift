//
//  Country.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/14/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class Country{
    
    let countryCode: String
    let countryName: String
    
    

    init(code : String , name : String) {
        self.countryCode = code
        self.countryName = name
    }
    
    
    func getCountryCode() -> String {
        return self.countryCode
    }
    
    func getCountryName() -> String {
        return self.countryName
    }
}
