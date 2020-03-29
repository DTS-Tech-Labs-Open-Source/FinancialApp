//
//  LoanComputeViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/8/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class LoanComputeViewController : UIViewController , CustomNumberKeyboardDelegate{
  
    @IBOutlet weak var loanPrincipalAmountText: UITextField!
    @IBOutlet weak var interestRateText: UITextField!
    @IBOutlet weak var monthlyPaymentText: UITextField!
    @IBOutlet weak var fullRepaymentText: UITextField!
    @IBOutlet weak var durationText: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outerStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var paymentStackView: UIStackView!
    @IBOutlet weak var outerStacKView: UIStackView!
    @IBOutlet weak var loanStackView: UIStackView!
    @IBOutlet weak var interestStackView: UIStackView!
    @IBOutlet weak var fullRepaymentStackView: UIStackView!
    @IBOutlet weak var durationStackView: UIStackView!
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 20.0
    var textFieldKeyBoardGap = 20
    var keyBoardHeight:CGFloat = 0
    
    var loanAddedArray = [LoanUnit]()
    var fillTextFild = [Int]()
    
    let findInterestRate = [1, 3, 5]
    let findPaymentPerMonth = [1, 2 ,5]
    let findLoanAmount = [3, 2, 5]
    let findduration = [1 , 2 ,3]
    
    var allTextFields :[UITextField] {return [loanPrincipalAmountText, interestRateText , monthlyPaymentText , fullRepaymentText , durationText  ]}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        if isTextFieldsEmpty() {
            self.navigationItem.rightBarButtonItem!.isEnabled = false;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loanPrincipalAmountText.setLightPlaceholder(UIColor.lightText , "Rupees")
        loanPrincipalAmountText.setAsNumberKeyboard(delegate: self)
        //
        interestRateText.setLightPlaceholder(UIColor.lightText , "Anual rate %")
        interestRateText.setAsNumberKeyboard(delegate: self)
        //
        monthlyPaymentText.setLightPlaceholder(UIColor.lightText , "Rupees")
        monthlyPaymentText.setAsNumberKeyboard(delegate: self)
        //
        fullRepaymentText.setLightPlaceholder(UIColor.lightText , "Rupees")
        fullRepaymentText.setAsNumberKeyboard(delegate: self)
        //
        durationText.setLightPlaceholder(UIColor.lightText , "Year")
        durationText.setAsNumberKeyboard(delegate: self)
                
         self.showKeyboardWhenTapTextField(ViewTopConstraint: outerStackViewTopConstraint, OuterStackView: outerStacKView, ScrollView: scrollView)
    }
    
    func isTextFieldsEmpty() -> Bool {
           if !(loanPrincipalAmountText.text?.isEmpty)! && !(interestRateText.text?.isEmpty)! &&
               !(monthlyPaymentText.text?.isEmpty)! && !(fullRepaymentText.text?.isEmpty)! &&
               !(durationText.text?.isEmpty)! {
               return false
           }
           return true
       }
    
    
    @IBAction func triggerTextFieldChanges(_ sender: UITextField) {
        
        var unit: LoanUnits?
        switch sender.tag {
               case Constants.TAG_NUMBER_1:
                unit = LoanUnits.loanAmount
                   storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                   break
               case Constants.TAG_NUMBER_2:
                unit = LoanUnits.interestRate
                   storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                   break
               case Constants.TAG_NUMBER_3:
                unit = LoanUnits.monthlyPayment
                   storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                   break
               case Constants.TAG_NUMBER_4:
                unit = LoanUnits.fullRepayment
                   storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                   break
               case Constants.TAG_NUMBER_5:
                unit = LoanUnits.duration
                   storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                   break
               default:
                   print ("defult")
               }

    }
    
    func storeAndInitilizeArrys(tag : Int , textField: UITextField , unit: LoanUnits) -> Void{

        if let input = textField.text{
            if input.isEmpty {
                self.navigationItem.rightBarButtonItem!.isEnabled = false;
                clearTextFields(tag : tag)
            }else{
                if fillTextFild.isEmpty {
                    fillTextFild.append(tag)
                    loanAddedArray += [LoanUnit(tagValue : tag , textField : textField , unit: unit)]
                }else{
                    if fillTextFild.contains(tag) {
                        loanAddedArray.filter{ $0.tagValue == tag }.first?.textField = textField
                        checkUnitComplete(unit: unit)
                    }else{
                        fillTextFild.append(tag)
                        loanAddedArray += [LoanUnit(tagValue : tag , textField : textField , unit: unit)]
                        checkUnitComplete(unit: unit)
                    }
                }
            }
        }
    }
    
    func checkUnitComplete(unit: LoanUnits){
           
           if fillTextFild.count >= Constants.TAG_NUMBER_3 {
               //updateTextFields()
               let calLoandUnit = LoanInvest(value: loanAddedArray)
               
               self.navigationItem.rightBarButtonItem!.isEnabled = true;
               
               if fillTextFild.containsSameElements(as : findInterestRate){
                   
                    let re = calLoandUnit.convert(unit: LoanUnits.interestRate)
                    updateTextFields(res: re, unit: unit)
                   
               }else if fillTextFild.containsSameElements(as : findLoanAmount){
                   
                    let re = calLoandUnit.convert(unit: LoanUnits.loanAmount)
                    updateTextFields(res: re, unit: unit)
                   
               }else if fillTextFild.containsSameElements(as : findduration){
                  
                    let re = calLoandUnit.convert(unit: LoanUnits.duration)
                    updateTextFields(res: re, unit: unit)
                   
               }else if fillTextFild.containsSameElements(as : findPaymentPerMonth){
                
                    let re = calLoandUnit.convert(unit: LoanUnits.monthlyPayment)
                    updateTextFields(res: re, unit: unit)
               }
           }else{
               print("not complete")
           }
    }
    @IBAction func triggerSaveButton(_ sender: UIBarButtonItem) {
        
        if !isTextFieldsEmpty(){
                   
            let compoundBoady = "\(loanPrincipalAmountText.text!) Loan Amount | \(interestRateText.text!) % Interest | \(monthlyPaymentText.text!) Per Month |  \(fullRepaymentText.text!) Full Payment | = \(durationText.text!) Num Of Pay"
                   
            var arr = UserDefaults.standard.array(forKey: Constants.LOAN_USER_DEFAULTS_KEY) as? [String] ?? []
                   
                   if arr.count >= Constants.USER_SAVE_MAX_DEFAULTS_COUNT {
                       arr = Array(arr.suffix(Constants.USER_SAVE_MAX_DEFAULTS_COUNT - 1))
                   }
                   
                   arr.append(compoundBoady)
                   UserDefaults.standard.set(arr, forKey: Constants.LOAN_USER_DEFAULTS_KEY)
                   let alert = UIAlertController(title: "Success", message: "The Loan Computation was successully saved!", preferredStyle: UIAlertController.Style.alert)
                              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
               }else{
                   let alert = UIAlertController(title: "Error", message: "You are trying to save an empty Computation!", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
               }
    }
    
    func updateTextFields(res : [FinalLoan] , unit : LoanUnits) -> Void {
         for itm in res {
             if itm.getUnit() == unit {
                 continue
             }
             let textfiled = mapTextAreawithUnit(unit: itm.getUnit())
             
             let roundedResult = Double(round(10000 * itm.getValue()) / 10000)
            
            if !loanAddedArray.contains(where: { $0.unit == itm.getUnit() }){
                                textfiled.isUserInteractionEnabled = false
            }
                     
             
             textfiled.text = String(roundedResult)
         }
     }
    
    func clearTextFields(tag : Int) {
        if fillTextFild.contains(tag){
            fillTextFild.remove(element: tag)
            if let indx = loanAddedArray.firstIndex(where: { $0.tagValue == tag }){
                loanAddedArray.remove(at: indx)
            }
        }
    }
    
    func mapTextAreawithUnit(unit: LoanUnits) -> UITextField {
         var textField = loanPrincipalAmountText
         switch unit {
         case .loanAmount:
             textField = loanPrincipalAmountText
         case .interestRate:
             textField = interestRateText
         case .monthlyPayment:
             textField = monthlyPaymentText
         case .fullRepayment:
             textField = fullRepaymentText
         case .duration:
             textField = durationText
         }
         return textField!
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
    
    func retractKeyPressed() {
        self.hideKeyboard()
        UIView.animate(withDuration: 0.25, animations: {
                        self.outerStackViewTopConstraint.constant = self.outerStackViewTopConstraintDefaultHeight
                        self.view.layoutIfNeeded()
        })
    }
    
    func numericAllClearPressed() {
          print("Clear All Text")
    }
    
    func clearAllTextFields() {
          loanPrincipalAmountText.text = ""
          interestRateText.text = ""
          monthlyPaymentText.text = ""
          fullRepaymentText.text = ""
          durationText.text = ""
          
          loanAddedArray.removeAll()
          fillTextFild.removeAll()
          
          self.navigationItem.rightBarButtonItem!.isEnabled = false;
          
          for row in allTextFields {
              row.isUserInteractionEnabled = true
          }
          
      }
    
}
