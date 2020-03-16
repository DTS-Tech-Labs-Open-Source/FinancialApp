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
    
    var countryArry = [Country]()
    var rateArray = [CurrencyRateUnit]()
    
    var selectFirstPicker:Bool = false
    var selectSeconfPicker:Bool = false
    
    var fisrtCountry :Country? = nil
    var secoundCountry :Country? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        if CheckInternetConnection.connection(){
            
            let cur = CuncurrencyService(APIKey: Constants.ACCESS_KEY)
            cur.getCountryList { (result) in
                if let coun = result{
                    DispatchQueue.main.async {
                        self.countryArry = coun
                        self.fisrtCountry = coun.first!
                        self.secoundCountry = coun.first!
                        
                        self.countrySelectOne.reloadComponent(0)
                        self.countrySelectTwo.reloadComponent(0)
                    }
                }
            }
            
            let rate = CuncurrencyService(APIKey: Constants.ACCESS_KEY)
            rate.getCurrencyRate { (respose) in
                if let ratCoun = respose{
                    DispatchQueue.main.async {
                        self.rateArray = ratCoun
                    }
                }
            }
            
        }else{
            self.Alert(Message: "Your Device is not connected with internet")
            self.currencyFirstInput.text = "Need connect Internet First !"
        }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    currencyFirstInput.setLightPlaceholder(UIColor.lightText , "Concurrency Value")
    currencyFirstInput.setAsNumberKeyboard(delegate: self)
    currencySeconInput.setLightPlaceholder(UIColor.lightText , "Concurrency Value")
    currencySeconInput.setAsNumberKeyboard(delegate: self)
    currencySeconInput.isUserInteractionEnabled = false
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    @IBAction func captureTextChanges(_ sender: UITextField) {
        
        
    }
    
    // chnage un
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRow = self.countryArry.count
        
        if pickerView == countrySelectOne{
            countRow = self.countryArry.count
        }
        
        return countRow
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: countryArry[row].getCountryName(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == countrySelectOne{
            let titelRow = self.countryArry[row].getCountryName()
            return titelRow
        }else if pickerView == countrySelectTwo{
            let titelRow = self.countryArry[row].getCountryName()
            return titelRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         if pickerView == countrySelectOne{
            self.selectFirstPicker = true
            self.fisrtCountry = self.countryArry[row]
            calculateCurruncyDif(tagLab: 1)
//            self.countrySelectOne.isHidden = true
        }else if pickerView == countrySelectTwo{
            self.selectSeconfPicker = true
            self.secoundCountry = self.countryArry[row]
            calculateCurruncyDif(tagLab: 2)
        }
    }
    
    func calculateCurruncyDif(tagLab : Int) -> Void {
        switch tagLab {
        case 1:
            //something
            if self.secoundCountry != nil {
                if !self.currencyFirstInput.text!.isEmpty{
                    if rateArray.contains(where: { $0.countryCode == self.fisrtCountry?.countryCode }){
                        
                        let inputDou = (currencyFirstInput.text! as NSString).doubleValue
                        let re = converter(firCode: (self.fisrtCountry?.getCountryCode())!, secCode: (self.secoundCountry?.getCountryCode())!, value:inputDou )
                        
                        currencySeconInput.text = "\(re)"
                    }
                }
            }
        case 2:
            //something
            if self.fisrtCountry != nil {
                if !self.currencySeconInput.text!.isEmpty{
                        let inputDou = (currencySeconInput.text! as NSString).doubleValue
                        let re = converter(firCode: (self.secoundCountry?.getCountryCode())!, secCode: (self.fisrtCountry?.getCountryCode())!, value:inputDou )
                        
                        currencyFirstInput.text = "\(re)"
                    
                }else if !self.currencyFirstInput.text!.isEmpty{
                        let inputDou = (currencyFirstInput.text! as NSString).doubleValue
                        let re = converter(firCode: (self.fisrtCountry?.getCountryCode())!, secCode: (self.secoundCountry?.getCountryCode())!, value:inputDou )
                        
                        currencySeconInput.text = "\(re)"

                }else if !self.currencyFirstInput.text!.isEmpty && !self.currencySeconInput.text!.isEmpty{
                    print("this")
                }
            }
        default:
            print("defult section")
        }
    }
    
    func converter(firCode:String , secCode:String , value: Double) -> Double {
        
        let firCountryRate = rateArray.first(where: {$0.countryCode == firCode})?.getCurrencyValue()
        let secCountryRate = rateArray.first(where: {$0.countryCode == secCode})?.getCurrencyValue()
        
        let result = secCountryRate! / firCountryRate! * value
        
        return result
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
