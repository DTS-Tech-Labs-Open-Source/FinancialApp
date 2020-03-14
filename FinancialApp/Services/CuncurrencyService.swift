//
//  CuncurrencyService.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/14/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class CuncurrencyService{
    
    let currencyAPIKey : String
    let currencyBaseURL : URL?

    init(APIKey :String) {
//        access_key=xxxxxxxxxxx
        self.currencyAPIKey = "access_key="+APIKey
        
        currencyBaseURL = URL(string: Constants.FIXER_BASE_URL)
    }

//    http://data.fixer.io/api/symbols?access_key=c8dd86141cf6d6e21dd02ca4ec8a0373
//    \(currencyBaseURL!)/ \(Constants.FIXER_GET_COUNTIES_URL)? \(self.currencyAPIKey)
 
    func getCountryList(_ compltion: @escaping ([Country]?) -> Void){
        
        
        var countryList = [Country]()
        
        if let countryURL = URL(string: "\(currencyBaseURL!)/\(Constants.FIXER_GET_COUNTIES_URL)?\(currencyAPIKey)"){
            
            if CheckInternetConnection.connection(){
                let httpReqest = HttpAdapterService.init(url: countryURL)
                httpReqest.downloanJSONFromURL { (jsonResponse) in
                    if let symbols = jsonResponse?["symbols"] as? [String:Any]{
                        for cu in symbols {
                            countryList += [Country(code: cu.key , name: cu.value as! String)]
                        }
                                      
                        compltion(countryList)
                    }
                }
            }
            
        }else{
            print("somthing worng with URL")
            compltion(nil)
        }
        
        
//        return countryList
    }

}
