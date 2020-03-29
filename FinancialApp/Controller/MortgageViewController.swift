//
//  MortgageViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/8/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class MortgageViewController: UIViewController , CustomNumberKeyboardDelegate {
 
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var loanAmountStackView: UIStackView!
    @IBOutlet weak var InterestStackView: UIStackView!
    @IBOutlet weak var paymentStackView: UIStackView!
    @IBOutlet weak var numOfPayStackView: UIStackView!
    
    @IBOutlet weak var loanAmountText: UITextField!
    @IBOutlet weak var interestText: UITextField!
    @IBOutlet weak var paymentText: UITextField!
    @IBOutlet weak var numOfPaymentText: UITextField!
    @IBOutlet weak var fullPayment: UITextField!
    @IBOutlet weak var outerStackViewContrainer: NSLayoutConstraint!
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 20.0
    var textFieldKeyBoardGap = 20
    var keyBoardHeight:CGFloat = 0
    
    var mortgageAddedArray = [MortgageUnit]()
    var fillTextFild = [Int]()
    
    let findInterestRate = [1, 3, 4]
    let findMonthlyPay = [1, 2 ,4]
    let findduration = [1, 2, 3]
    let findLoanAmount = [2 , 3 ,4]
    
    var allTextFields :[UITextField] {return [loanAmountText, interestText , paymentText , numOfPaymentText , fullPayment  ]}
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        
        if isTextFieldsEmpty() {
            self.navigationItem.rightBarButtonItem!.isEnabled = false;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set Text Field Styles
        
          loanAmountText.setLightPlaceholder(UIColor.lightText , "Rupees")
          loanAmountText.setAsNumberKeyboard(delegate: self)
          
          interestText.setLightPlaceholder(UIColor.lightText , "Anual rate %")
          interestText.setAsNumberKeyboard(delegate: self)
          
          paymentText.setLightPlaceholder(UIColor.lightText , "Rupees")
          paymentText.setAsNumberKeyboard(delegate: self)
          
          numOfPaymentText.setLightPlaceholder(UIColor.lightText , "Years")
          numOfPaymentText.setAsNumberKeyboard(delegate: self)

          fullPayment.setLightPlaceholder(UIColor.lightText , "Rupees")
          fullPayment.setAsNumberKeyboard(delegate: self)
          
        self.showKeyboardWhenTapTextField(ViewTopConstraint: outerStackViewContrainer, OuterStackView: outerStackView, ScrollView: scrollView)
    }
    
    func isTextFieldsEmpty() -> Bool {
             if !(loanAmountText.text?.isEmpty)! && !(interestText.text?.isEmpty)! &&
                 !(paymentText.text?.isEmpty)! && !(numOfPaymentText.text?.isEmpty)! &&
                !(fullPayment.text?.isEmpty)! {
                 return false
             }
             return true
         }
    
    @IBAction func triggerTextFieldChanges(_ sender: UITextField) {
        
        var unit: MortgageUnits?
              
          
                  switch sender.tag {
                         case Constants.TAG_NUMBER_1:
                             unit = MortgageUnits.loanAmount
                             storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                             break
                         case Constants.TAG_NUMBER_2:
                             unit = MortgageUnits.interestRate
                             storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                             break
                         case Constants.TAG_NUMBER_3:
                            unit = MortgageUnits.monthlyPayment
                             storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                             break
                         case Constants.TAG_NUMBER_4:
                             unit = MortgageUnits.duration
                             storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                             break
                         case Constants.TAG_NUMBER_5:
                            unit = MortgageUnits.fullPayment
                             storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                             break
                         default:
                             print ("defult")
                         }
    }
    
    func storeAndInitilizeArrys(tag : Int , textField: UITextField , unit: MortgageUnits) -> Void{

        if let input = textField.text{
            if input.isEmpty {
                self.navigationItem.rightBarButtonItem!.isEnabled = false;
                clearTextFields(tag : tag)
            }else{
                if fillTextFild.isEmpty {
                        fillTextFild.append(tag)
                    mortgageAddedArray += [MortgageUnit(tagValue : tag , textField : textField , unit: unit)]
                }else{
                    if fillTextFild.contains(tag) {
                        mortgageAddedArray.filter{ $0.tagValue == tag }.first?.textField = textField
                        checkUnitComplete(unit: unit)
                    }else{
                        fillTextFild.append(tag)
                        mortgageAddedArray += [MortgageUnit(tagValue : tag , textField : textField , unit: unit)]
                        checkUnitComplete(unit: unit)
                    }
                }
            }
        }
    }
    
    func checkUnitComplete(unit: MortgageUnits){
           
           
           if fillTextFild.count >= Constants.TAG_NUMBER_3 {
              
               let calMortgageUnit = MortgageInvest(value: mortgageAddedArray)
               
               self.navigationItem.rightBarButtonItem!.isEnabled = true;
               
               if fillTextFild.containsSameElements(as : findInterestRate){
                   // this for find interest
                    let re = calMortgageUnit.convert(unit: MortgageUnits.interestRate)
                    updateTextFields(res: re, unit: unit)
                   
               }else if fillTextFild.containsSameElements(as : findMonthlyPay){
                   //this is for find payment per month
                    let re = calMortgageUnit.convert(unit: MortgageUnits.monthlyPayment)
                    updateTextFields(res: re, unit: unit)
                   
               }else if fillTextFild.containsSameElements(as : findduration){
                    // this is for find duration
                    let re = calMortgageUnit.convert(unit: MortgageUnits.duration)
                    updateTextFields(res: re, unit: unit)
                   
               }else if fillTextFild.containsSameElements(as : findLoanAmount){
                    //this is for calculate loan amount
                    let re = calMortgageUnit.convert(unit: MortgageUnits.loanAmount)
                    updateTextFields(res: re, unit: unit)
               }
           }else{
               print("not complete")
           }
       }
    
    func updateTextFields(res : [FinalMortgage] , unit : MortgageUnits) -> Void {
        for itm in res {
            if itm.getUnit() == unit {
                continue
            }
            let textfiled = mapTextAreawithUnit(unit: itm.getUnit())
            
            let roundedResult = Double(round(10000 * itm.getValue()) / 10000)
            
            if !mortgageAddedArray.contains(where: { $0.unit == itm.getUnit() }){
                textfiled.isUserInteractionEnabled = false
            }
                        
            
            textfiled.text = String(roundedResult)
        }
    }
    
    @IBAction func saveButtonAction(_ sender: UIBarButtonItem) {
        if !isTextFieldsEmpty(){
                   
                   let compoundBoady = "\(loanAmountText.text!) Loan Amount | \(interestText.text!) % Interest | \(paymentText.text!) Payment per Month |  \(numOfPaymentText.text!) Num Of Pay | = \(fullPayment.text!) Full Pay"
                   
                   var arr = UserDefaults.standard.array(forKey: Constants.MORTGAGE_USER_DEFAULTS_KEY) as? [String] ?? []
                   
                   if arr.count >= Constants.USER_SAVE_MAX_DEFAULTS_COUNT {
                       arr = Array(arr.suffix(Constants.USER_SAVE_MAX_DEFAULTS_COUNT - 1))
                   }
                   
                   arr.append(compoundBoady)
                   UserDefaults.standard.set(arr, forKey: Constants.MORTGAGE_USER_DEFAULTS_KEY)
                   let alert = UIAlertController(title: "Success", message: "The Mortgage Computation was successully saved!", preferredStyle: UIAlertController.Style.alert)
                              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
               }else{
                   let alert = UIAlertController(title: "Error", message: "You are trying to save an empty Computation!", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
               }
    }
    
    func mapTextAreawithUnit(unit: MortgageUnits) -> UITextField {
          var textField = loanAmountText
          switch unit {
          case .loanAmount:
              textField = loanAmountText
          case .interestRate:
              textField = interestText
          case .monthlyPayment:
              textField = paymentText
          case .duration:
              textField = numOfPaymentText
          case .fullPayment:
              textField = fullPayment
          }
          return textField!
      }
     
    
    func clearTextFields(tag : Int) {
        if fillTextFild.contains(tag){
            fillTextFild.remove(element: tag)
            if let indx = mortgageAddedArray.firstIndex(where: { $0.tagValue == tag }){
                mortgageAddedArray.remove(at: indx)
            }
        }
    }
    
    func numericKeyPressed(key: Int) {
         print("Numeric key \(key) pressed!")
     }
     
     func numericBackspacePressed() {
        print("Backspace pressed!")
     }
     
     func numericClearPressed() {
          clearAllTextFields()
     }
     
     func numericSymbolPressed(symbol: String) {
         print("Symbol \(symbol) pressed!")
     }
    
    func numericAllClearPressed() {
             print("Clear All Text")
       }
     
     func retractKeyPressed() {
          self.hideKeyboard()
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.outerStackViewContrainer.constant = self.outerStackViewTopConstraintDefaultHeight
                    self.view.layoutIfNeeded()
                })
     }
    
    
    func clearAllTextFields() {
            loanAmountText.text = ""
            interestText.text = ""
            paymentText.text = ""
            numOfPaymentText.text = ""
            fullPayment.text = ""
            
            mortgageAddedArray.removeAll()
            fillTextFild.removeAll()
            
            self.navigationItem.rightBarButtonItem!.isEnabled = false;
            
            for row in allTextFields {
                row.isUserInteractionEnabled = true
            }
            
        }
    
}
