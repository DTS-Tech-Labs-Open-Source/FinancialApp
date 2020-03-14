//
//  CompoundLoanViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/7/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class CompoundLoanViewController : UIViewController , CustomNumberKeyboardDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var presentValueTxt: UITextField!
    @IBOutlet weak var presentValueStackView: UIStackView!
    @IBOutlet weak var futureValuetxt: UITextField!
    @IBOutlet weak var futureValueStackView: UIStackView!
    @IBOutlet weak var interestValueTxt: UITextField!
    @IBOutlet weak var interestValueStackView: UIStackView!
    @IBOutlet weak var paymentValueTxt: UITextField!
    @IBOutlet weak var paymentValueStackView: UIStackView!
    @IBOutlet weak var numberOfPayment: UITextField!
    @IBOutlet weak var numberOfPaymentStackView: UIStackView!
    @IBOutlet weak var outerStackViewTopConstraint: NSLayoutConstraint!
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 20.0
    var textFieldKeyBoardGap = 20
    var keyBoardHeight:CGFloat = 0
    
    var compoundAddedArray = [CompoundUnit]()
    var fillTextFild = [Int]()
    
    let findInterestRate = [1, 2, 5]
    let findPrinciple = [2, 3 ,5]
    let findduration = [1, 2, 3]
    let findFututerVal = [1 , 3 ,5]
    
    var allTextFields :[UITextField] {return [presentValueTxt, futureValuetxt , interestValueTxt , paymentValueTxt , numberOfPayment  ]}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        if isTextFieldsEmpty() {
            self.navigationItem.rightBarButtonItem!.isEnabled = false;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set Text Field Styles
      
        presentValueTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        presentValueTxt.setAsNumberKeyboard(delegate: self)
        
        futureValuetxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        futureValuetxt.setAsNumberKeyboard(delegate: self)
        
        interestValueTxt.setLightPlaceholder(UIColor.lightText , "Anual rate %")
        interestValueTxt.setAsNumberKeyboard(delegate: self)
        
        paymentValueTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        paymentValueTxt.setAsNumberKeyboard(delegate: self)

        numberOfPayment.setLightPlaceholder(UIColor.lightText , "Year Count")
        numberOfPayment.setAsNumberKeyboard(delegate: self)
        
        self.showKeyboardWhenTapTextField(ViewTopConstraint: outerStackViewTopConstraint, OuterStackView: outerStackView, ScrollView: scrollView)
   
    }
    
    
    
   
    @IBAction func captureTextFieldChanges(_ sender: UITextField) {
        
        var unit: CompoundUnits?
        
    
            switch sender.tag {
                   case Constants.TAG_NUMBER_1:
                       unit = CompoundUnits.pricipalValue
                       storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                       break
                   case Constants.TAG_NUMBER_2:
                       unit = CompoundUnits.futureValue
                       storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                       break
                   case Constants.TAG_NUMBER_3:
                       unit = CompoundUnits.interestRate
                       storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                       break
                   case Constants.TAG_NUMBER_4:
                       unit = CompoundUnits.monthlyPayment
                       storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                       break
                   case Constants.TAG_NUMBER_5:
                       unit = CompoundUnits.duration
                       storeAndInitilizeArrys(tag: sender.tag, textField: sender , unit: unit!)
                       break
                   default:
                       print ("defult")
                   }
       
    }
    

    @IBAction func triggerSaveActionButton(_ sender: UIBarButtonItem) {
        
        if !isTextFieldsEmpty(){
            
            let compoundBoady = "\(presentValueTxt.text!) Principal | \(futureValuetxt.text!) Future Value | \(interestValueTxt.text!) % Interest |  \(paymentValueTxt.text!) Per Month | = \(numberOfPayment.text!) Num Of Pay"
            
            var arr = UserDefaults.standard.array(forKey: Constants.COMPOUND_USER_DEFAULTS_KEY) as? [String] ?? []
            
            if arr.count >= Constants.USER_SAVE_MAX_DEFAULTS_COUNT {
                arr = Array(arr.suffix(Constants.USER_SAVE_MAX_DEFAULTS_COUNT - 1))
            }
            
            arr.append(compoundBoady)
            UserDefaults.standard.set(arr, forKey: Constants.COMPOUND_USER_DEFAULTS_KEY)
            let alert = UIAlertController(title: "Success", message: "The Compound Computation was successully saved!", preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: "You are trying to save an empty Computation!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func storeAndInitilizeArrys(tag : Int , textField: UITextField , unit: CompoundUnits) -> Void{

        if let input = textField.text{
            if input.isEmpty {
                self.navigationItem.rightBarButtonItem!.isEnabled = false;
                clearTextFields(tag : tag)
            }else{
                if fillTextFild.isEmpty {
                        fillTextFild.append(tag)
                    compoundAddedArray += [CompoundUnit(tagValue : tag , textField : textField , unit: unit)]
                }else{
                    if fillTextFild.contains(tag) {
                        compoundAddedArray.filter{ $0.tagValue == tag }.first?.textField = textField
                        checkUnitComplete(unit: unit)
                    }else{
                        fillTextFild.append(tag)
                        compoundAddedArray += [CompoundUnit(tagValue : tag , textField : textField , unit: unit)]
                        checkUnitComplete(unit: unit)
                    }
                }
            }
        }
    }
    
    func checkUnitComplete(unit: CompoundUnits){
        
        
        if fillTextFild.count >= Constants.TAG_NUMBER_3 {
            //updateTextFields()
            let calCompoundUnit = CompoundInvest(value: compoundAddedArray)
            
            self.navigationItem.rightBarButtonItem!.isEnabled = true;
            
            if fillTextFild.containsSameElements(as : findInterestRate){
                
                let re = calCompoundUnit.convert(unit: CompoundUnits.interestRate)
                updateTextFields(res: re, unit: unit)
                
            }else if fillTextFild.containsSameElements(as : findPrinciple){
                
                let re = calCompoundUnit.convert(unit: CompoundUnits.pricipalValue)
                updateTextFields(res: re, unit: unit)
                
            }else if fillTextFild.containsSameElements(as : findduration){
               
                let re = calCompoundUnit.convert(unit: CompoundUnits.duration)
                updateTextFields(res: re, unit: unit)
                
            }else if fillTextFild.containsSameElements(as : findFututerVal){
                let re = calCompoundUnit.convert(unit: CompoundUnits.futureValue)
                updateTextFields(res: re, unit: unit)
            }
        }else{
            print("not complete")
        }
    }
    
    func updateTextFields(res : [FinalCompound] , unit : CompoundUnits) -> Void {
        for itm in res {
            if itm.getUnit() == unit {
                continue
            }
            
            let textfiled = mapTextAreawithUnit(unit: itm.getUnit())
            
            let roundedResult = Double(round(10000 * itm.getValue()) / 10000)
            
            if !compoundAddedArray.contains(where: { $0.unit == itm.getUnit() }){
                textfiled.isUserInteractionEnabled = false
            }
            
            textfiled.text = String(roundedResult)
        }
    }
      
    func mapTextAreawithUnit(unit: CompoundUnits) -> UITextField {
         var textField = presentValueTxt
         switch unit {
         case .pricipalValue:
             textField = presentValueTxt
         case .futureValue:
             textField = futureValuetxt
         case .duration:
             textField = numberOfPayment
         case .monthlyPayment:
             textField = paymentValueTxt
         case .interestRate:
             textField = interestValueTxt
         }
         return textField!
     }
    
    func clearTextFields(tag : Int) {
        if fillTextFild.contains(tag){
            fillTextFild.remove(element: tag)
            if let indx = compoundAddedArray.firstIndex(where: { $0.tagValue == tag }){
                compoundAddedArray.remove(at: indx)
            }
        }
    }
    

    
    func isTextFieldsEmpty() -> Bool {
           if !(presentValueTxt.text?.isEmpty)! && !(futureValuetxt.text?.isEmpty)! &&
               !(interestValueTxt.text?.isEmpty)! && !(paymentValueTxt.text?.isEmpty)! &&
               !(numberOfPayment.text?.isEmpty)! {
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
    
    func numericClearPressed(){
        print("Clear Text filed")
//        clearTextFields()
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
        presentValueTxt.text = ""
        futureValuetxt.text = ""
        interestValueTxt.text = ""
        paymentValueTxt.text = ""
        numberOfPayment.text = ""
        
        compoundAddedArray.removeAll()
        fillTextFild.removeAll()
        
        self.navigationItem.rightBarButtonItem!.isEnabled = false;
        
        for row in allTextFields {
            row.isUserInteractionEnabled = true
        }
        
    }
    
}
