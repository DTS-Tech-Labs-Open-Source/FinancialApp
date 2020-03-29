//
//  SavingComputeViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/8/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class SavingComputeViewController : UIViewController , CustomNumberKeyboardDelegate{

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var princiapleAmountTxt: UITextField!
    @IBOutlet weak var interestTxt: UITextField!
    @IBOutlet weak var paymentTxt: UITextField!
    @IBOutlet weak var finalTotalBalanceTxt: UITextField!
    @IBOutlet weak var futureValueTxt: UITextField!
    @IBOutlet weak var outerStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var numOfPaymentsTxt: UITextField!
    @IBOutlet weak var princiapleAmountStakView: UIStackView!
    @IBOutlet weak var interestStakView: UIStackView!
    @IBOutlet weak var paymentStakView: UIStackView!
    @IBOutlet weak var compoundPerYearStakView: UIStackView!
    @IBOutlet weak var futureValueStakView: UIStackView!
    @IBOutlet weak var numOfPaymentStakView: UIStackView!
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 20.0
    var textFieldKeyBoardGap = 20
    var keyBoardHeight:CGFloat = 0
    
    var savingAddedArray = [SavingUnit]()
    var fillTextFild = [Int]()
       
    let findInterestRate = [1, 2, 5]
    let findPrinciple = [2, 3 ,5]
    let findduration = [1, 2, 3]
    let findFututerVal = [1 , 3 ,5]
    
        var allTextFields :[UITextField] {return [princiapleAmountTxt, interestTxt , paymentTxt , finalTotalBalanceTxt , futureValueTxt , numOfPaymentsTxt ]}
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.hideKeyboardWhenTappedAround()
        
        if isTextFieldsEmpty() {
            
            self.navigationItem.rightBarButtonItem!.isEnabled = false;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
        princiapleAmountTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        princiapleAmountTxt.setAsNumberKeyboard(delegate: self)
        //
        interestTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        interestTxt.setAsNumberKeyboard(delegate: self)
        //
        paymentTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        paymentTxt.setAsNumberKeyboard(delegate: self)
        //
        finalTotalBalanceTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        finalTotalBalanceTxt.setAsNumberKeyboard(delegate: self)
        //
        futureValueTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        futureValueTxt.setAsNumberKeyboard(delegate: self)
        
        numOfPaymentsTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        numOfPaymentsTxt.setAsNumberKeyboard(delegate: self)
                
         self.showKeyboardWhenTapTextField(ViewTopConstraint: outerStackViewTopConstraint, OuterStackView: outerStackView, ScrollView: scrollView)
    }
    
    @IBAction func captureTextFieldChanges(_ sender: UITextField) {
        
        var unit: SavingUnits?
        
        switch sender.tag {
        case Constants.TAG_NUMBER_1:
            unit = SavingUnits.presentAmount
            storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
            break
        case Constants.TAG_NUMBER_2:
            unit = SavingUnits.interestRate
            storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
            break
        case Constants.TAG_NUMBER_3:
            unit = SavingUnits.paymentPreMonth
            storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
            break
        case Constants.TAG_NUMBER_4:
            unit = SavingUnits.finalTotalAmount
            storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
            break
        case Constants.TAG_NUMBER_5:
            unit = SavingUnits.futureAmount
            storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
            break
        case Constants.TAG_NUMBER_5:
            unit = SavingUnits.duration
                   storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                   break
        default:
            print ("defult")
        }
    }
    
    func storeAndInitilizeArrys(tag : Int , textField: UITextField , unit: SavingUnits) -> Void{

        if let input = textField.text{
            if input.isEmpty {
                self.navigationItem.rightBarButtonItem!.isEnabled = false;
                clearTextFields(tag : tag)
            }else{
                if fillTextFild.isEmpty {
                    fillTextFild.append(tag)
                
                    savingAddedArray += [SavingUnit(tagValue : tag , textField : textField , unit: unit)]
                }else{
                    if fillTextFild.contains(tag) {
                        savingAddedArray.filter{ $0.tagValue == tag }.first?.textField = textField
                        checkUnitComplete(unit: unit)
                    }else{
                        fillTextFild.append(tag)
                        savingAddedArray += [SavingUnit(tagValue : tag , textField : textField , unit: unit)]
                        checkUnitComplete(unit: unit)
                    }
                }
            }
        }
    }
    
    func checkUnitComplete(unit: SavingUnits){


          if fillTextFild.count >= Constants.TAG_NUMBER_3 {
              //updateTextFields()
              let calSavingUnit = SavingInvest(value: savingAddedArray)

              self.navigationItem.rightBarButtonItem!.isEnabled = true;

              if fillTextFild.containsSameElements(as : findInterestRate){

                  let re = calSavingUnit.convert(unit: SavingUnits.interestRate)
                  updateTextFields(res: re, unit: unit)

              }else if fillTextFild.containsSameElements(as : findPrinciple){

                let re = calSavingUnit.convert(unit: SavingUnits.presentAmount)
                  updateTextFields(res: re, unit: unit)

              }else if fillTextFild.containsSameElements(as : findduration){

                let re = calSavingUnit.convert(unit: SavingUnits.duration)
                  updateTextFields(res: re, unit: unit)

              }else if fillTextFild.containsSameElements(as : findFututerVal){
                let re = calSavingUnit.convert(unit: SavingUnits.futureAmount)
                  updateTextFields(res: re, unit: unit)
              }
          }else{
              print("not complete")
          }
      }
    
    func updateTextFields(res : [FinalSaving] , unit : SavingUnits) -> Void {
        for itm in res {
            if itm.getUnit() == unit {
                continue
            }
            let textfiled = mapTextAreawithUnit(unit: itm.getUnit())
            
            let roundedResult = Double(round(10000 * itm.getValue()) / 10000)
            
            if !savingAddedArray.contains(where: { $0.unit == itm.getUnit() }){
                       textfiled.isUserInteractionEnabled = false
                   }
            
            textfiled.text = String(roundedResult)
        }
    }
    
    func mapTextAreawithUnit(unit: SavingUnits) -> UITextField {
         var textField = princiapleAmountTxt
         switch unit {
         case .presentAmount:
             textField = princiapleAmountTxt
         case .interestRate:
             textField = interestTxt
         case .paymentPreMonth:
             textField = paymentTxt
         case .finalTotalAmount:
             textField = finalTotalBalanceTxt
         case .futureAmount:
             textField = futureValueTxt
         case .duration:
            textField = numOfPaymentsTxt
         }
         return textField!
     }
    
    func clearTextFields(tag : Int) {
        if fillTextFild.contains(tag){
            fillTextFild.remove(element: tag)
            if let indx = savingAddedArray.firstIndex(where: { $0.tagValue == tag }){
                savingAddedArray.remove(at: indx)
            }
        }
    }
    
    func isTextFieldsEmpty() -> Bool {
           if !(princiapleAmountTxt.text?.isEmpty)! && !(interestTxt.text?.isEmpty)! &&
                !(paymentTxt.text?.isEmpty)! &&
               !(finalTotalBalanceTxt.text?.isEmpty)! && !(futureValueTxt.text?.isEmpty)! && !(numOfPaymentsTxt.text?.isEmpty)! {
               return false
           }
           return true
       }
    
    
    
    func numericKeyPressed(key: Int) {
        print("Numeric key \(key) pressed!")
    }
    
    func numericBackspacePressed() {
        print("Backspace pressed!")
    }
    
    func numericClearPressed() {
        print("Clear Text filed")
    }
    
    func numericSymbolPressed(symbol: String) {
        print("Symbol \(symbol) pressed!")
    }
    
    func numericAllClearPressed() {
             clearAllTextFields()
        
    }
    
    func retractKeyPressed() {
        self.hideKeyboard()
        
        UIView.animate(withDuration: 0.25, animations: {
                  self.outerStackViewTopConstraint.constant = self.outerStackViewTopConstraintDefaultHeight
                  self.view.layoutIfNeeded()
              })
    }
    
    func clearAllTextFields() {
        princiapleAmountTxt.text = ""
        paymentTxt.text = ""
        interestTxt.text = ""
        finalTotalBalanceTxt.text = ""
        futureValueTxt.text = ""
        numOfPaymentsTxt.text = ""
        
        savingAddedArray.removeAll()
        fillTextFild.removeAll()
        
        self.navigationItem.rightBarButtonItem!.isEnabled = false;
        
        for row in allTextFields {
            row.isUserInteractionEnabled = true
        }
        
    }
    
}
