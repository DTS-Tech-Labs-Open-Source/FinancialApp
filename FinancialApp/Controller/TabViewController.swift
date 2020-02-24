//
//  TabViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 2/25/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // instruct UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController is ComputeViewController {
            print("Conversions tab")
        } else if viewController is HistoryViewController {
            print("History tab")
        } else if viewController is SettingViewController {
            print("Constants tab")
        }
    }
}
