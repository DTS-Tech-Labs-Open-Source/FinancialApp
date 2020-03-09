//
//  UITextInputView+PlaceholderColor.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/7/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit


// MARK: - This extension can be used to make the placeholder in UIText field to be lighter.
extension UITextField {
    
    
    /// This function sets the passed in color to the text field placeholder.
    ///
    /// - Parameter color: The colour to be set.
    func setLightPlaceholder(_ color: UIColor , _ key : String) {
        var placeholderText = key
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}
