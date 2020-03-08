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
    @IBOutlet weak var compoundPerYearTxt: UITextField!
    @IBOutlet weak var compoundPerYearStackView: UIStackView!
    @IBOutlet weak var outerStackViewTopConstraint: NSLayoutConstraint!
    
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
        
        // Set Text Field Styles
       presentValueTxt._lightPlaceholderColor(UIColor.lightText)
       presentValueTxt.setAsNumericKeyboard(delegate: self)
//
       futureValuetxt._lightPlaceholderColor(UIColor.lightText)
       futureValuetxt.setAsNumericKeyboard(delegate: self)
//
       interestValueTxt._lightPlaceholderColor(UIColor.lightText)
       interestValueTxt.setAsNumericKeyboard(delegate: self)
//
       paymentValueTxt._lightPlaceholderColor(UIColor.lightText)
       paymentValueTxt.setAsNumericKeyboard(delegate: self)
//
       numberOfPayment._lightPlaceholderColor(UIColor.lightText)
       numberOfPayment.setAsNumericKeyboard(delegate: self)
//
       compoundPerYearTxt._lightPlaceholderColor(UIColor.lightText)
       compoundPerYearTxt.setAsNumericKeyboard(delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification : NSNotification){
        
        let firstResponder = self.findFirstResponder(inView: self.view)
        
        if firstResponder != nil {
            activeTextField = firstResponder as! UITextField;
            
            let activeTextFieldSuperView = activeTextField.superview!

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
           if !(presentValueTxt.text?.isEmpty)! && !(futureValuetxt.text?.isEmpty)! &&
               !(interestValueTxt.text?.isEmpty)! && !(paymentValueTxt.text?.isEmpty)! &&
               !(numberOfPayment.text?.isEmpty)! && !(compoundPerYearTxt.text?.isEmpty)! {
               return false
           }
           return true
       }
    
    /// This function clears all the text fields
       func clearTextFields() {
           presentValueTxt.text = ""
           futureValuetxt.text = ""
           interestValueTxt.text = ""
           paymentValueTxt.text = ""
           numberOfPayment.text = ""
           compoundPerYearTxt.text = ""
       }
       
    
    func numericKeyPressed(key: Int) {
        print("nnnii")
        print("Numeric key \(key) pressed!")
    }
    
    func numericBackspacePressed() {
        print("Backspace pressed!")

    }
    
    func numericClearPressed(){
//        clearTextFields()
    }
    
    func numericSymbolPressed(symbol: String) {
        print("Symbol \(symbol) pressed!")

    }
    
    func retractKeyPressed() {
        keyboardWillHide()
    }
    
    
    
}
