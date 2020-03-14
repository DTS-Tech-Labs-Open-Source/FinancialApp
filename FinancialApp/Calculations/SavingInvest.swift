//
//  SavingInvest.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

enum SavingUnits {
    
    case presentAmount
    case interestRate
    case futureAmount
    case paymentPreMonth
    case duration
    case finalTotalAmount
    
    
    static let getAllUnits = [presentAmount , interestRate , futureAmount  , paymentPreMonth , duration , finalTotalAmount ]
}

struct SavingInvest {

    let value:[SavingUnit]

    init(value: [SavingUnit]) {
      self.value = value
    }
    
    func convert(unit: SavingUnits) -> [FinalSaving] {
        
        var output = [FinalSaving]()
        var loanAmount : Double = 0.0
        var interest : Double = 0.0
        var monthPay : Double = 0.0
        var duration : Double = 0.0
//
//        switch unit {
//        case .presentAmount:
//            break
//        case .futureAmount:
//            break
//        case .interestRate:
//            <#code#>
//        case .paymentPreMonth:
//            <#code#>
//        case .duration:
//            <#code#>
//        case .finalTotalAmount:
//            <#code#>
//        }
        return output
    }
    
    func calculatePresentAmount(futureAmount:Double , interest: Double , duration: Double) -> [FinalSaving] {
        var output = [FinalSaving]()
        
//         let answer: Double = A / (1 + R * t)
        
        return output
    }
    
    func calculateFutureAmount(presentAmount:Double , interest: Double , duration: Double) -> [FinalSaving] {
        var output = [FinalSaving]()
//         let answer: Double =  P * (1 + R * t)
        return output
    }

    func calculateInterest(futureAmount:Double , ppresentAmount: Double , duration: Double) -> [FinalSaving] {
        var output = [FinalSaving]()
//         let answer: Double = ( 1 / t ) * ( A / P - 1 )
        return output
    }
    
    func calculatePaymentPerMonth() -> Void{
        //guhihoi
    }
    
    func calculateDuration(futureAmount:Double , ppresentAmount: Double , interest: Double) -> [FinalSaving] {
        var output = [FinalSaving]()
        
//        let answer: Double = ( 1 / R ) * ( A / P - 1 )
        return output
    }
    
    func calculateFinalTotalAmount(futureAmount:Double , ppresentAmount: Double) -> [FinalSaving] {
        var output = [FinalSaving]()
//         let answer: Double =  A + P
        return output
    }
}
