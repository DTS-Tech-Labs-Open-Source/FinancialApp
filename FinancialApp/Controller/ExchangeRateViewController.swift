//
//  ExchangeRateViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/8/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , CustomNumberKeyboardDelegate{

    @IBOutlet weak var currencyFirstInput: UITextField!
    @IBOutlet weak var currencySeconInput: UITextField!
    @IBOutlet weak var countrySelectOne: UIPickerView!
    @IBOutlet weak var countrySelectTwo: UIPickerView!
    
    let food = ["test1" , "test2" , "test3" , "test3" , "test4"]
    let animal = ["dog" , "cat" , "fish","rat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
//        if CheckInternetConnection.connection(){
//                   self.Alert(Message: "Connected")
//        }else{
//                   self.Alert(Message: "Your Device is not connected with internet")
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    currencyFirstInput.setLightPlaceholder(UIColor.lightText , "Rupees")
    currencyFirstInput.setAsNumberKeyboard(delegate: self)
    currencySeconInput.setLightPlaceholder(UIColor.lightText , "Rupees")
    currencySeconInput.setAsNumberKeyboard(delegate: self)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRow = self.food.count
        
        if pickerView == countrySelectOne{
            countRow = self.food.count
        }
        
        return countRow
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: food[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == countrySelectOne{
            let titelRow = self.food[row]
            return titelRow
        }else if pickerView == countrySelectTwo{
            let titelRow = self.food[row]
            return titelRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         if pickerView == countrySelectOne{
            self.currencyFirstInput.text = self.food[row]
//            self.countrySelectOne.isHidden = true
        }else if pickerView == countrySelectTwo{
            self.currencySeconInput.text = self.food[row]
        }
    }
    
    func Alert (Message: String){
          
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
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
    
    func numericAllClearPressed() {
        print("Clear All Text")
    }
    
    func numericSymbolPressed(symbol: String) {
        print("Symbol \(symbol) pressed!")
    }
    
    func retractKeyPressed() {
         self.hideKeyboard()
    }
    

}
