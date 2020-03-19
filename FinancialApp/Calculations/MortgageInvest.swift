//
//  MortgageInvest.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/10/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

enum MortgageUnits {
    
    case loanAmount
    case interestRate
    case monthlyPayment
    case duration
    case fullPayment
    
    static let getAllUnits = [loanAmount , interestRate , monthlyPayment , duration , fullPayment  ]
    
}

struct MortgageInvest {
    
    let value:[MortgageUnit]
      
    init(value: [MortgageUnit]) {
          self.value = value
    }
    
    func convert(unit: MortgageUnits) -> [FinalMortgage] {
        
        var output = [FinalMortgage]()
        var loanAmount : Double = 0.0
        var interest : Double = 0.0
        var monthPay : Double = 0.0
        var duration : Double = 0.0

        switch unit {
        case .duration:
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == MortgageUnits.loanAmount{
                    loanAmount = Double(out!)!
                  
                }else if iem.getUnit() == MortgageUnits.interestRate{
                    interest = Double(out!)!
                    
                }else if iem.getUnit() == MortgageUnits.monthlyPayment{
                    monthPay = Double(out!)!
                }
            }
            output = calculateLoanDuration(loanAmount: loanAmount, interest: interest, monthPay: monthPay)
            break
        case .interestRate:
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == MortgageUnits.loanAmount{
                    loanAmount = Double(out!)!
                  
                }else if iem.getUnit() == MortgageUnits.duration{
                    duration = Double(out!)!
                    
                }else if iem.getUnit() == MortgageUnits.monthlyPayment{
                    monthPay = Double(out!)!
                }
            }
            output = calculateInteretRate(loanAmount: loanAmount, monthPay: monthPay, duration: duration)
            break
        case .monthlyPayment:
            
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == MortgageUnits.loanAmount{
                    loanAmount = Double(out!)!
                  
                }else if iem.getUnit() == MortgageUnits.duration{
                    duration = Double(out!)!
                    
                }else if iem.getUnit() == MortgageUnits.interestRate{
                    interest = Double(out!)!
                }
            }
            output = calculateMonthlyPayment(loanAmount: loanAmount, interest: duration, duration: interest)
            break
        case .loanAmount :
           
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == MortgageUnits.monthlyPayment{
                    monthPay = Double(out!)!
                  
                }else if iem.getUnit() == MortgageUnits.duration{
                    duration = Double(out!)!
                    
                }else if iem.getUnit() == MortgageUnits.interestRate{
                    interest = Double(out!)!
                }
            }
            output = calculateLoanAmount(interest: interest, monthPay: monthPay, duration: duration)
            break
        case .fullPayment:
            print("ttt")
            //this is not in use
            break
        }
        return output
    }
    
    func calculateInteretRate(loanAmount:Double , monthPay: Double , duration: Double) -> [FinalMortgage] {
        var interestV :Double = 0.0
        var output = [FinalMortgage]()
        var fullPayment : Double = 0.0
        
        output.append(FinalMortgage(value: loanAmount, unit: MortgageUnits.loanAmount))
        output.append(FinalMortgage(value: monthPay, unit: MortgageUnits.monthlyPayment))
        output.append(FinalMortgage(value: duration, unit: MortgageUnits.duration))
        
        var x = Double(1) + (((monthPay * duration / loanAmount) - Double(1)) / Double(Constants.INTEREST_UNIT_TIME)) // initial guess
               // var x = 0.1;
        let FINANCIAL_PRECISION = Double(0.000001) // 1e-6

        func F(_ x: Double) -> Double { // f(x)
              // (loan * x * (1 + x)^n) / ((1+x)^n - 1) - pmt
            return Double(loanAmount * x * pow(1 + x, duration) / (pow(1+x, duration) - 1) - monthPay);
        }
        func FPrime(_ x: Double) -> Double { // f'(x)
                   // (loan * (x+1)^(n-1) * ((x*(x+1)^n + (x+1)^n-n*x-x-1)) / ((x+1)^n - 1)^2)
            let c_derivative = pow(x+1, duration)
            return Double(loanAmount * pow(x+1, duration-1) * (x * c_derivative + c_derivative - (duration * x) - x - 1)) / pow(c_derivative - 1, 2)
        }
        while(abs(F(x)) > FINANCIAL_PRECISION) {
             x = x - F(x) / FPrime(x)
         }
        
        interestV = Double(12 * x * 100)
        fullPayment = monthPay * duration * Double(Constants.INTEREST_UNIT_TIME)
        output.append(FinalMortgage(value: interestV, unit: MortgageUnits.interestRate))
        output.append(FinalMortgage(value: fullPayment, unit: MortgageUnits.fullPayment))
        
        return output
    }
    
     func calculateLoanAmount(interest:Double , monthPay: Double , duration: Double) -> [FinalMortgage] {
        var loanAmountV :Double = 0.0
        var output = [FinalMortgage]()
        var fullPayment : Double = 0.0
        
        output.append(FinalMortgage(value: interest, unit: MortgageUnits.interestRate))
        output.append(FinalMortgage(value: monthPay, unit: MortgageUnits.monthlyPayment))
        output.append(FinalMortgage(value: duration, unit: MortgageUnits.duration))
        
        let st1 =  Double(interest) / Double(Constants.INTEREST_UNIT_TIME)
        let st2 = Double(Double(Constants.INTEREST_UNIT_TIME) * Double(duration))
        let st3 = Double(monthPay) * (pow((st1 + Double(1)), st2) - Double(1))
        
        let st4 = st1 * pow((st1 + Double(1)), st2)
        
        loanAmountV = st3 / st4
        fullPayment = monthPay * duration * Double(Constants.INTEREST_UNIT_TIME)
        output.append(FinalMortgage(value: loanAmountV, unit: MortgageUnits.loanAmount))
        output.append(FinalMortgage(value: fullPayment, unit: MortgageUnits.fullPayment))
       
        
        return output
     }
    
    func calculateMonthlyPayment(loanAmount:Double , interest: Double , duration: Double) -> [FinalMortgage]{
         //  let answer: Double = (P * ( R/t * pow((1 + R/t), (n*t)))) / ( pow((1 + R/t), (n*t)) - 1 )
//        M = P[r(1+r)^n/((1+r)^n)-1)]


        var monthPayV :Double = 0.0
        var output = [FinalMortgage]()
        var fullPayment : Double = 0.0
        
        output.append(FinalMortgage(value: loanAmount, unit: MortgageUnits.loanAmount))
        output.append(FinalMortgage(value: interest, unit: MortgageUnits.interestRate))
        output.append(FinalMortgage(value: duration, unit: MortgageUnits.duration))
        
        let st1 = interest / duration
        let st2 = Double(Constants.INTEREST_UNIT_TIME) * duration
        let st3 = loanAmount * ( st1 * pow((Double(1) + st1), st2))
        let st4 = pow((Double(1) + st1), st2) - Double(1)
        
        monthPayV = st3 / st4
        fullPayment = monthPayV * duration * Double(Constants.INTEREST_UNIT_TIME)
        output.append(FinalMortgage(value: monthPayV, unit: MortgageUnits.monthlyPayment))
        output.append(FinalMortgage(value: fullPayment, unit: MortgageUnits.fullPayment))
       
        
        return output
    }
    
    func calculateLoanDuration(loanAmount:Double , interest: Double , monthPay: Double) -> [FinalMortgage] {
   
        var durationV :Double = 0.0
        var output = [FinalMortgage]()
        var fullPayment : Double = 0.0
        
        output.append(FinalMortgage(value: loanAmount, unit: MortgageUnits.loanAmount))
        output.append(FinalMortgage(value: monthPay, unit: MortgageUnits.monthlyPayment))
        output.append(FinalMortgage(value: interest, unit: MortgageUnits.interestRate))
        
        let st1 = (Double(interest)/100) * Double(Constants.INTEREST_UNIT_TIME)
        let st2 = log(Double(monthPay)/st1)
        let st3 = log(Double((monthPay / st1) - Double(loanAmount)))
        let st4 = log( Double (1) + st1)
        
        let an = st2 - (st3 / st4)
        
        durationV = an / Double(Constants.INTEREST_UNIT_TIME)
        
        fullPayment = monthPay * durationV * Double(Constants.INTEREST_UNIT_TIME)
        
        output.append(FinalMortgage(value: durationV, unit: MortgageUnits.duration))
        output.append(FinalMortgage(value: fullPayment, unit: MortgageUnits.fullPayment))
        
        return output
    }
}
