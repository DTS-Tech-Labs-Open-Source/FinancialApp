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
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide)))
        
        if isTextFieldsEmpty() {
            
            self.navigationItem.rightBarButtonItem!.isEnabled = false;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        princiapleAmountTxt._lightPlaceholderColor(UIColor.lightText)
        princiapleAmountTxt.setAsNumericKeyboard(delegate: self)
        //
        interestTxt._lightPlaceholderColor(UIColor.lightText)
        interestTxt.setAsNumericKeyboard(delegate: self)
        //
        paymentTxt._lightPlaceholderColor(UIColor.lightText)
        paymentTxt.setAsNumericKeyboard(delegate: self)
        //
        compoundsPerYearTxt._lightPlaceholderColor(UIColor.lightText)
        compoundsPerYearTxt.setAsNumericKeyboard(delegate: self)
        //
        paymentPerYearTxt._lightPlaceholderColor(UIColor.lightText)
        paymentPerYearTxt.setAsNumericKeyboard(delegate: self)
        //
        futureValueTxt._lightPlaceholderColor(UIColor.lightText)
        futureValueTxt.setAsNumericKeyboard(delegate: self)
        
        numOfPaymentsTxt._lightPlaceholderColor(UIColor.lightText)
        numOfPaymentsTxt.setAsNumericKeyboard(delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                                      name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
           
           let firstResponder = self.findFirstResponder(inView: self.view)
           
           if firstResponder != nil {
               activeTextField = firstResponder as! UITextField;
               
               var activeTextFieldSuperView = activeTextField.superview!
               
               if activeTextField.tag == 5 || activeTextField.tag == 6 {
                   activeTextFieldSuperView = activeTextField.superview!.superview!
               }
               
               if let info = notification.userInfo {
                   let keyboard:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
                   
                   let targetY = view.frame.size.height - keyboard.height - 15 - activeTextField.frame.size.height
                   
                   let initialY = outerStackView.frame.origin.y + activeTextFieldSuperView.frame.origin.y + activeTextField.frame.origin.y
                   
                   if initialY > targetY {
                       let diff = targetY - initialY
                       let targetOffsetForTopConstraint = outerStackViewTopConstraint.constant + diff
                       self.view.layoutIfNeeded()
                       
                       UIView.animate(withDuration: 0.25, animations: {
                           self.outerStackViewTopConstraint.constant = targetOffsetForTopConstraint
                           self.view.layoutIfNeeded()
                       })
                   }
                   
                   var contentInset:UIEdgeInsets = self.scrollView.contentInset
                   contentInset.bottom = keyboard.size.height
                   scrollView.contentInset = contentInset
               }
           }
       }
    
    func findFirstResponder(inView view: UIView) -> UIView? {
        for subView in view.subviews {
            if subView.isFirstResponder {
                return subView
            }
            
            if let recursiveSubView = self.findFirstResponder(inView: subView) {
                return recursiveSubView
            }
        }
        
        return nil
    }
    @objc func keyboardWillHide() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.outerStackViewTopConstraint.constant = self.outerStackViewTopConstraintDefaultHeight
            self.view.layoutIfNeeded()
        })
        
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
        print("ede")
    }
    
    func numericBackspacePressed() {
        print("dcscd")
    }
    
    func numericClearPressed() {
        print("cdcs")
    }
    
    func numericSymbolPressed(symbol: String) {
        print("cdsc")
    }
    
    func retractKeyPressed() {
        print("sdcs")
    }
    
}
