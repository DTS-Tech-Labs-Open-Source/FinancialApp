//
//  UIView+HideAndShowKeyboard.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/8/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

private var outerConstraint : NSLayoutConstraint? = nil
private var textFieldActive = UITextField()
private var outerStackView : UIStackView? = nil
private var scrollView : UIScrollView? = nil

extension UIViewController {
    
    
    func hideKeyboardWhenTappedAround(ViewTopConstraint: NSLayoutConstraint) {
        
        outerConstraint = ViewTopConstraint
           let tapGesture = UITapGestureRecognizer(target: self,
                                                   action: #selector(hideKeyboard(ViewTopConstraint:)))
           view.addGestureRecognizer(tapGesture)
       }
       
    @objc func hideKeyboard(ViewTopConstraint: NSLayoutConstraint) {
        
        let outerStackViewTopConstraintDefaultHeight: CGFloat = 17.0
          
        view.endEditing(true)
        
        
        UIView.animate(withDuration: 0.25, animations: {
            ViewTopConstraint.constant = outerStackViewTopConstraintDefaultHeight
                 self.view.layoutIfNeeded()
             })
       }
    
    
    func showKeyboardWhenTapTextField( ViewTopConstraint: NSLayoutConstraint , OuterStackView: UIStackView , ScrollView: UIScrollView){
        
        outerConstraint = ViewTopConstraint
        outerStackView = OuterStackView
        scrollView = ScrollView
        
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                                       name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        
        let firstResponder = self.findFirstResponder(inView: self.view)
        if firstResponder != nil {
            
            textFieldActive = firstResponder as! UITextField;
            
            var activeTextFieldSuperView = textFieldActive.superview!
            
            if textFieldActive.tag == 5 || textFieldActive.tag == 6 {
                activeTextFieldSuperView = textFieldActive.superview!.superview!
            }
            
            if let info = notification.userInfo {
                
                let keyboard:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
                
                let targetY = view.frame.size.height - keyboard.height - 15 - textFieldActive.frame.size.height
                
                let initialY = outerStackView!.frame.origin.y + activeTextFieldSuperView.frame.origin.y + textFieldActive.frame.origin.y
                
                if initialY > targetY {
                    let diff = targetY - initialY
                    let targetOffsetForTopConstraint = outerConstraint!.constant + diff
                    self.view.layoutIfNeeded()
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        outerConstraint!.constant = targetOffsetForTopConstraint
                        self.view.layoutIfNeeded()
                    })
                }
                
                var contentInset:UIEdgeInsets = scrollView!.contentInset
                contentInset.bottom = keyboard.size.height
                scrollView!.contentInset = contentInset

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
    
    
}
