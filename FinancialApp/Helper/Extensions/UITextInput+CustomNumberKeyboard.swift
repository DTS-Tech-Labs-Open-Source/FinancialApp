//
//  UITextInput+CustomNumberKeyboard.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/7/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

private var numberKeyboardDelegate: CustomNumberKeyboardDelegate? = nil


// MARK: - This extension can be used to make UITextFields as a part of the custom numeric keyboard.
extension UITextField: CustomNumberKeyboardDelegate {
    
    /// This function sets the text field as a part of numeric keyboard.
    ///
    /// - Parameter delegate: The deligate
    func setAsNumberKeyboard(delegate: CustomNumberKeyboardDelegate?) {
        let numericKeyboard = CustomNumberPadController(frame: CGRect(x: 0, y: 0, width: 0, height: customNKbRecommendedHeight))
        self.inputView = numericKeyboard
        numberKeyboardDelegate = delegate
        numericKeyboard.delegate = self
    }
    
    
    /// This function unsets the text field as a part of numeric keyboard.
    func unsetAsNumericKeyboard() {
        if let numericKeyboard = self.inputView as? CustomNumberPadController {
            numericKeyboard.delegate = nil
        }
        self.inputView = nil
        numberKeyboardDelegate = nil
    }
    
    /// This function handles the numeric key press. It inserts the
    /// corresponding numeric value to the text field text.
    ///
    /// - Parameter key: The numeric key pressed.
    internal func numericKeyPressed(key: Int) {
        self.insertText(String(key))
        numberKeyboardDelegate?.numericKeyPressed(key: key)
    }
    
    
    /// This function handles the backspace key press. It removes a charater
    /// from the inserted text in the text field.
    internal func numericBackspacePressed() {
        self.deleteBackward()
        numberKeyboardDelegate?.numericBackspacePressed()
    }
    
    internal func numericClearPressed(){
        self.text = ""
        numberKeyboardDelegate?.numericClearPressed()
    }
    
    
    /// This function handles the symbol key press. It inserts the
    /// corresponding symbol to the text field text.
    ///
    /// - Parameter symbol: The symbol pressed.
    internal func numericSymbolPressed(symbol: String) {
        self.insertText(String(symbol))
        numberKeyboardDelegate?.numericSymbolPressed(symbol: symbol)
    }
    
    
    /// This function handles the retract keboard key press. It invokes
    /// the retractKeyPressed() method in the numberKeyboardDelegate.
    internal func retractKeyPressed() {
        numberKeyboardDelegate?.retractKeyPressed()
    }
    
    internal func numericAllClearPressed() {
        numberKeyboardDelegate?.numericAllClearPressed()
    }
}
