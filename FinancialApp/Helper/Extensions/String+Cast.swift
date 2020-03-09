//
//  String+Cast.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/9/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
