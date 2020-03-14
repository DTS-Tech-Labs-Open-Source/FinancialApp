//
//  LoanInvest.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

enum LoanUnits {
    
    case loanAmount
    case interestRate
    case monthlyPayment
    case fullRepayment
    case duration
    
    
    static let getAllUnits = [loanAmount , interestRate , monthlyPayment  , duration , fullRepayment  ]
    
}

struct LoanInvest {
    
    let value:[LoanUnit]
    
    init(value: [LoanUnit]) {
          self.value = value
    }
    
    func convert(unit: LoanUnits) -> [FinalLoan] {
        
        var output = [FinalLoan]()
        var loanAmount : Double = 0.0
        var interest : Double = 0.0
        var monthPay : Double = 0.0
        var duration : Double = 0.0
        
        switch unit {
      
        case .loanAmount:
            for iem in value {
                let out = iem.getTextValue().text
                    if iem.getUnit() == LoanUnits.monthlyPayment{
                              monthPay = Double(out!)!
                    }
                    else if iem.getUnit() == LoanUnits.duration{
                              duration = Double(out!)!
                              
                    }else if iem.getUnit() == LoanUnits.interestRate{
                              interest = Double(out!)!
                    }
                }
            output = calculateLoanAmount(interest: interest, monthPay: monthPay, duration: duration)
            break
        case .interestRate:
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == LoanUnits.loanAmount{
                    loanAmount = Double(out!)!
                  
                }else if iem.getUnit() == LoanUnits.duration{
                    duration = Double(out!)!
                    
                }else if iem.getUnit() == LoanUnits.monthlyPayment{
                    monthPay = Double(out!)!
                }
            }
            output = calculateInteretRate(loanAmount: loanAmount, monthPay: monthPay, duration: duration)
            break
        case .monthlyPayment:
            
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == LoanUnits.loanAmount{
                    loanAmount = Double(out!)!
                  
                }else if iem.getUnit() == LoanUnits.duration{
                    duration = Double(out!)!
                    
                }else if iem.getUnit() == LoanUnits.interestRate{
                    interest = Double(out!)!
                }
            }
            
            output = calculateMonthlyPayment(loanAmount: loanAmount, interest: interest, duration: duration)
            break
        case .duration:
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == LoanUnits.loanAmount{
                    loanAmount = Double(out!)!
                  
                }else if iem.getUnit() == LoanUnits.interestRate{
                    interest = Double(out!)!
                    
                }else if iem.getUnit() == LoanUnits.monthlyPayment{
                    monthPay = Double(out!)!
                }
            }
            output = calculateLoanDuration(loanAmount: loanAmount, interest: interest, monthPay: monthPay)
            break
        case .fullRepayment:
            print("ttt")
            break
        }
        return output
    }
    
    func calculateInteretRate(loanAmount:Double , monthPay: Double , duration: Double) -> [FinalLoan] {
        var interestV :Double = 0.0
        var output = [FinalLoan]()
        var fullPayment : Double = 0.0
        
        output.append(FinalLoan(value: loanAmount, unit: LoanUnits.loanAmount))
        output.append(FinalLoan(value: monthPay, unit: LoanUnits.monthlyPayment))
        output.append(FinalLoan(value: duration, unit: LoanUnits.duration))
        

        var x = 1 + (((monthPay * duration / loanAmount) - Double(1)) / Double(Constants.INTEREST_UNIT_TIME))
        let FINANCIAL_PRECISION = Double(0.000001)
        
        func F(_ x: Double) -> Double {
              return Double(loanAmount * x * pow((Double(1) + x), duration) / (pow((Double(1)+x), duration) - 1) - monthPay);
          }
        
        func FPrime(_ x: Double) -> Double {
              let c_derivative = pow(x+1, duration)
              return Double(loanAmount * pow((x+Double(1)), (duration - Double(1))) *
                  (x * c_derivative + c_derivative - (duration*x) - x - Double(1))) / pow((c_derivative - Double(1)), Double(2))
          }
        
        while(abs(F(x)) > FINANCIAL_PRECISION) {
                 x = x - F(x) / FPrime(x)
        }
        interestV = Double(Constants.INTEREST_UNIT_TIME) * x * Double(100)
          
        output.append(FinalLoan(value: interestV, unit: LoanUnits.interestRate))
        output.append(FinalLoan(value: fullPayment, unit: LoanUnits.fullRepayment))
        
        
        return output
    }
    
    func calculateLoanAmount(interest:Double , monthPay: Double , duration: Double) -> [FinalLoan] {
        var loanAmountV :Double = 0.0
        var output = [FinalLoan]()
        var fullPayment : Double = 0.0
        let st1 = interest / Double(Constants.INTEREST_UNIT_TIME)
        loanAmountV = monthPay / st1 * (Double(1) - (Double(1) - (1 / pow( (Double(1) + st1), duration ))))
        
        
        output.append(FinalLoan(value: interest, unit: LoanUnits.interestRate))
        output.append(FinalLoan(value: monthPay, unit: LoanUnits.monthlyPayment))
        output.append(FinalLoan(value: duration, unit: LoanUnits.duration))
        
        output.append(FinalLoan(value: loanAmountV, unit: LoanUnits.loanAmount))
        output.append(FinalLoan(value: fullPayment, unit: LoanUnits.fullRepayment))
        
        return output
    }
    
    func calculateMonthlyPayment(loanAmount:Double , interest: Double , duration: Double) -> [FinalLoan]{
        
        var monthPayV :Double = 0.0
        var output = [FinalLoan]()
        var fullPayment : Double = 0.0
        
        output.append(FinalLoan(value: loanAmount, unit: LoanUnits.loanAmount))
        output.append(FinalLoan(value: interest, unit: LoanUnits.interestRate))
        output.append(FinalLoan(value: duration, unit: LoanUnits.duration))
        
        let st1 = interest / Double(Constants.INTEREST_UNIT_TIME)
        let st2 = loanAmount * st1 * (pow((Double(1) + st1), duration))
        let st3 = (pow((Double(1) + st1), duration)) - Double(1)
        monthPayV = st2 / st3
        
        
        output.append(FinalLoan(value: monthPayV, unit: LoanUnits.monthlyPayment))
        output.append(FinalLoan(value: fullPayment, unit: LoanUnits.fullRepayment))
        return output
    }
    
    func calculateLoanDuration(loanAmount:Double , interest: Double , monthPay: Double) -> [FinalLoan] {
        var durationV :Double = 0.0
        var output = [FinalLoan]()
        var fullPayment : Double = 0.0
        
        output.append(FinalLoan(value: loanAmount, unit: LoanUnits.loanAmount))
        output.append(FinalLoan(value: monthPay, unit: LoanUnits.monthlyPayment))
        output.append(FinalLoan(value: interest, unit: LoanUnits.interestRate))
        
//        let i = (R / 12)
//        let answer: Double = log((PMT/i) / ((PMT/i) - P)) / log(1 + i)
        let st1 = interest / Double(Constants.INTEREST_UNIT_TIME)
        durationV = log((monthPay/st1) / ((monthPay/st1) - loanAmount)) / log(Double(1) + st1)
        
        
        output.append(FinalLoan(value: durationV, unit: LoanUnits.duration))
        output.append(FinalLoan(value: fullPayment, unit: LoanUnits.fullRepayment))
        
        return output
    }
}
