//
//  CompoundInvest.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/9/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

enum CompoundUnits {
    
    case pricipalValue
    case futureValue
    case interestRate
    case duration
    case monthlyPayment
    
    static let getAllUnits = [pricipalValue ,futureValue , interestRate , duration , monthlyPayment  ]
    
}

struct CompoundInvest {
    
    let value:[CompoundUnit]
  
    
    init(value: [CompoundUnit]) {
        self.value = value
    }
    
    func convert(unit: CompoundUnits) -> [FinalCompound] {
        var output = [FinalCompound]()
        var principal : Double = 0.0
        var future : Double = 0.0
        var duration : Double = 0.0
        var interest : Double = 0.0
               
        switch unit {
        case .interestRate :
        
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == CompoundUnits.futureValue{
                    future = Double(out!)!
                  
                }else if iem.getUnit() == CompoundUnits.duration{
                    duration = Double(out!)!
                    
                }else if iem.getUnit() == CompoundUnits.pricipalValue{
                    principal = Double(out!)!
                }
            }
            output = calculateInteretRate(future: future, duration: duration, principal: principal)
            break
        case .pricipalValue:
            
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == CompoundUnits.futureValue{
                    future = Double(out!)!
                  
                }else if iem.getUnit() == CompoundUnits.duration{
                    duration = Double(out!)!
                    
                }else if iem.getUnit() == CompoundUnits.interestRate{
                    interest = Double(out!)!
                }
            }
            output = calculatePrincipalValue(future: future, duration: duration, interest: interest)
            break
        case .futureValue:
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == CompoundUnits.duration{
                    duration = Double(out!)!
                  
                }else if iem.getUnit() == CompoundUnits.pricipalValue{
                    principal = Double(out!)!
                    
                }else if iem.getUnit() == CompoundUnits.interestRate{
                    interest = Double(out!)!
                }
            }
            output = calculateFutureValue (duration: duration, principal: principal, interest: interest)
            break
        case .duration:
            for iem in value {
                let out = iem.getTextValue().text
                if iem.getUnit() == CompoundUnits.futureValue{
                    future = Double(out!)!
                  
                }else if iem.getUnit() == CompoundUnits.pricipalValue{
                    principal = Double(out!)!
                    
                }else if iem.getUnit() == CompoundUnits.interestRate{
                    interest = Double(out!)!
                }
            }
            output = calculateDurationValue(future: future, principal: principal, interest: interest)
            break
        case .monthlyPayment:
            print("svcskh")
            break
        }
        
        return output
    }
    
    func calculateInteretRate(future:Double , duration: Double , principal: Double) -> [FinalCompound] {
        
        var interest :Double = 0.0
        var output = [FinalCompound]()
        var paymentPerMonth : Double
        
        
        output.append(FinalCompound(value: future, unit: CompoundUnits.futureValue))
        output.append(FinalCompound(value: duration, unit: CompoundUnits.duration))
        output.append(FinalCompound(value: principal, unit: CompoundUnits.pricipalValue))
        
        let aDivideByP = Double(future) / Double(principal)
        let timeDue = Double(1) / Double(Double(Constants.INTEREST_UNIT_TIME) * Double(duration))
        interest = Double(Constants.INTEREST_UNIT_TIME) * (Double(pow(aDivideByP, timeDue))-1)
        
        paymentPerMonth = Double(future) / Double(Double(duration) * Double(Constants.INTEREST_UNIT_TIME))
        
        output.append(FinalCompound(value: interest , unit: CompoundUnits.interestRate))
        output.append(FinalCompound(value: paymentPerMonth , unit: CompoundUnits.monthlyPayment))
        
        return output
    }
    
    func calculatePrincipalValue(future:Double , duration: Double , interest: Double) -> [FinalCompound]{
        
        var principalV :Double = 0.0
        var output = [FinalCompound]()
        var paymentPerMonth : Double = 0.0
        
        output.append(FinalCompound(value: future, unit: CompoundUnits.futureValue))
        output.append(FinalCompound(value: duration, unit: CompoundUnits.duration))
        output.append(FinalCompound(value: interest, unit: CompoundUnits.interestRate))
        
        let emi = Double(1) + ( Double(interest) / Double(Constants.INTEREST_UNIT_TIME))
        let timeDue = Double(Double(Constants.INTEREST_UNIT_TIME) * Double(duration))
        
        principalV = Double(future) / Double(pow(emi, timeDue))
        paymentPerMonth = Double(future) / Double(Double(duration) * Double(Constants.INTEREST_UNIT_TIME))
        
        output.append(FinalCompound(value: principalV , unit: CompoundUnits.pricipalValue))
        output.append(FinalCompound(value: paymentPerMonth , unit: CompoundUnits.monthlyPayment))
        
        return output
    }
    
    func calculateDurationValue(future:Double , principal: Double , interest: Double) -> [FinalCompound] {
        
        var durationV :Double = 0.0
        var output = [FinalCompound]()
        var paymentPerMonth : Double = 0.0
               
        output.append(FinalCompound(value: future, unit: CompoundUnits.futureValue))
        output.append(FinalCompound(value: principal, unit: CompoundUnits.pricipalValue))
        output.append(FinalCompound(value: interest, unit: CompoundUnits.interestRate))
        
        let aDivideByP = log(Double(future) /  Double(principal))
        let timeIn = log(Double(1) + (Double(interest) / Double (Constants.INTEREST_UNIT_TIME)))
        
        durationV = aDivideByP / (Double(Constants.INTEREST_UNIT_TIME) * timeIn)
        paymentPerMonth = Double(future) / Double(durationV * Double(Constants.INTEREST_UNIT_TIME))
        
        output.append(FinalCompound(value: durationV , unit: CompoundUnits.duration))
        output.append(FinalCompound(value: paymentPerMonth , unit: CompoundUnits.monthlyPayment))
        
        return output
    }
    
    func calculateFutureValue(duration: Double , principal: Double , interest: Double) -> [FinalCompound]{
        var futureV :Double = 0.0
        var output = [FinalCompound]()
        var paymentPerMonth : Double = 0.0
               
        output.append(FinalCompound(value: duration, unit: CompoundUnits.duration))
        output.append(FinalCompound(value: principal, unit: CompoundUnits.pricipalValue))
        output.append(FinalCompound(value: interest, unit: CompoundUnits.interestRate))
        
       
        let timeIn = (Double(1) + (Double(interest) / Double (Constants.INTEREST_UNIT_TIME)))

        let timeEi =  (Double(Constants.INTEREST_UNIT_TIME) * duration)
        futureV = principal * (pow(timeIn, timeEi))
        paymentPerMonth = Double(futureV) / Double(duration * Double(Constants.INTEREST_UNIT_TIME))
        
        output.append(FinalCompound(value: futureV , unit: CompoundUnits.futureValue))
        output.append(FinalCompound(value: paymentPerMonth , unit: CompoundUnits.monthlyPayment))
        
        return output
    }
}
