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
    @IBOutlet weak var compoundsPerYearTxt: UITextField!
    @IBOutlet weak var paymentPerYearTxt: UITextField!
    @IBOutlet weak var futureValueTxt: UITextField!
    @IBOutlet weak var outerStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var numOfPaymentsTxt: UITextField!
    @IBOutlet weak var princiapleAmountStakView: UIStackView!
    @IBOutlet weak var interestStakView: UIStackView!
    @IBOutlet weak var paymentStakView: UIStackView!
    @IBOutlet weak var compoundPerYearStakView: UIStackView!
    @IBOutlet weak var paymentPerYearStakView: UIStackView!
    @IBOutlet weak var futureValueStakView: UIStackView!
    @IBOutlet weak var numOfPaymentStakView: UIStackView!
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 17.0
    var textFieldKeyBoardGap = 20
    var keyBoardHeight:CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.hideKeyboardWhenTappedAround(ViewTopConstraint: self.outerStackViewTopConstraint)
        
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
        compoundsPerYearTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        compoundsPerYearTxt.setAsNumberKeyboard(delegate: self)
        //
        paymentPerYearTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        paymentPerYearTxt.setAsNumberKeyboard(delegate: self)
        //
        futureValueTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        futureValueTxt.setAsNumberKeyboard(delegate: self)
        
        numOfPaymentsTxt.setLightPlaceholder(UIColor.lightText , "Rupees")
        numOfPaymentsTxt.setAsNumberKeyboard(delegate: self)
                
         self.showKeyboardWhenTapTextField(ViewTopConstraint: outerStackViewTopConstraint, OuterStackView: outerStackView, ScrollView: scrollView)
    }
    
    
    func isTextFieldsEmpty() -> Bool {
           if !(princiapleAmountTxt.text?.isEmpty)! && !(interestTxt.text?.isEmpty)! &&
               !(paymentPerYearTxt.text?.isEmpty)! && !(paymentTxt.text?.isEmpty)! &&
               !(compoundsPerYearTxt.text?.isEmpty)! && !(futureValueTxt.text?.isEmpty)! && !(numOfPaymentsTxt.text?.isEmpty)! {
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
    
    func retractKeyPressed() {
        self.hideKeyboardWhenTappedAround(ViewTopConstraint:self.outerStackViewTopConstraint)
    }
    
}
