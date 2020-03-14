//
//  CustomNumberPadController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/7/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

// public constant which sets the recommended keyboard height
let customNKbRecommendedHeight = 300.00

// private constants to set button colours
private let defaultKeyColour = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00)
private let pressedKeyColour = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.00)

@objc protocol CustomNumberKeyboardDelegate {
    func numericKeyPressed(key: Int)
    func numericBackspacePressed()
    func numericClearPressed()
    func numericAllClearPressed()
    func numericSymbolPressed(symbol: String)
    func retractKeyPressed()
}

class CustomNumberPadController: UIView {
    
    @IBOutlet weak var butKey0: RoundButton!
    @IBOutlet weak var butKey1: RoundButton!
    @IBOutlet weak var butKey2: RoundButton!
    @IBOutlet weak var butKey3: RoundButton!
    @IBOutlet weak var butKey4: RoundButton!
    @IBOutlet weak var butKey5: RoundButton!
    @IBOutlet weak var butKey6: RoundButton!
    @IBOutlet weak var butKey7: RoundButton!
    @IBOutlet weak var butKey8: RoundButton!
    @IBOutlet weak var butKey9: RoundButton!
    @IBOutlet weak var butKeyMinus: RoundButton!
    @IBOutlet weak var butKeyDot: RoundButton!
    @IBOutlet weak var butKeyBackPress: RoundButton!
    @IBOutlet weak var butKeyClear: RoundButton!
    @IBOutlet weak var allClearPress: RoundButton!
    @IBOutlet weak var butKeyHidePad: UIButton!
    
     var allButtons: [UIButton] { return [butKey0, butKey1, butKey2, butKey3, butKey4, butKey5, butKey6, butKey7, butKey8, butKey9, butKeyDot, butKeyMinus] }
    
    weak var delegate : CustomNumberKeyboardDelegate?
   
    // appearance variables
    var btnDefaultBgColour = defaultKeyColour { didSet { updateButtonAppearance() } }
    var btnPressedBgColour = pressedKeyColour { didSet { updateButtonAppearance() } }
    var btnDefaultFontColor = UIColor.gray { didSet { updateButtonAppearance() } }
    var btnPressedFontColor = UIColor.white { didSet { updateButtonAppearance() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(enableMinusButton(notification:)),
                                               name: NSNotification.Name(rawValue: "enableMinusButton"), object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeKeyboard()
    }
    
    func initializeKeyboard() {
        let xibFileName = "CustomNumberPad"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        updateButtonAppearance()
        
        // disables minus button by default
        butKeyMinus.isUserInteractionEnabled = false
    }
    
    // This function changes button appearance in different states.
    fileprivate func updateButtonAppearance() {
        for button in allButtons {
            button.setTitleColor(btnDefaultFontColor, for: .normal)
            button.setTitleColor(btnPressedFontColor, for: [.selected, .highlighted])
            if button.isSelected {
                button.backgroundColor = btnPressedBgColour
            } else {
                button.backgroundColor = btnDefaultBgColour
            }
        }
    }
    
    // This function can be used to programatically enable the minus button.
    @objc func enableMinusButton(notification: NSNotification) {
        butKeyMinus.isUserInteractionEnabled = true
    }
    
    @IBAction func handleNumericButtonPress(_ sender: UIButton) {
        self.delegate?.numericKeyPressed(key: sender.tag)
    }
    
    
    @IBAction func handleBackspaceButtonPress(_ sender: AnyObject) {
        self.delegate?.numericBackspacePressed()
    }
    
    @IBAction func handleAllClearBurronPress(_ sender: UIButton) {
        self.delegate?.numericAllClearPressed()
    }
    
    @IBAction func handleClearButtonPress(_ sender: UIButton) {
        self.delegate?.numericClearPressed()
    }
    
    @IBAction func handleSymbolButtonPress(_ sender: UIButton) {
        if let symbol = sender.titleLabel?.text, symbol.count > 0 {
                   self.delegate?.numericSymbolPressed(symbol: symbol)
               }
    }
    @IBAction func handleHidePadButtonPress(_ sender: Any) {
       self.delegate?.retractKeyPressed()
    }
}
