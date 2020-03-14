//
//  HttpAdapterService.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 3/12/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import Foundation

class HttpAdapterService {
    
    lazy var configaration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configaration)
    let url: URL
    
    init(url : URL) {
        self.url = url
    }
    
    typealias JSONDictationryHandler = (([String : Any]?) -> Void)
    
    func downloanJSONFromURL(_ compltion: @escaping JSONDictationryHandler){
        
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse{
                    switch httpResponse.statusCode {
                    case 200:
                        if let data = data{
                            do {
                                let jsonResponce = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                compltion(jsonResponce as? [String:Any])
                            }catch let error as NSError{
                                print("Error processing data : \(error.localizedDescription)")
                            }
                        }
                    default:
                        print(" HTTP Response Statcode : \(httpResponse.statusCode)")
                    }
                }
            }else {
                print("Error : \(error?.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
