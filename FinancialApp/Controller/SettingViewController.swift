//
//  SettingViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 2/25/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
     var helpViews = [Help]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
                }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
      }
    
    func generateHelpViews() {
           
         
        let compDiscription = NSMutableAttributedString()
        compDiscription.append(stringFormatter(text: "me = ", location: 1, length: 1, type: "sub"))
        let cd = Help(name: "Compound loan", discription: compDiscription, icon: UIImage(named: "loan1")!)
        
        let savDiscription = NSMutableAttributedString()
        savDiscription.append(stringFormatter(text: "mp = ", location: 1, length: 1, type: "sub"))
        let sd = Help(name: "Saving Unit", discription: savDiscription, icon: UIImage(named: "loan2")!)
        
        
        let loanDiscription = NSMutableAttributedString()
        loanDiscription.append(stringFormatter(text: "mn = ", location: 1, length: 1, type: "sub"))
        let ld = Help(name: "Normal Loan", discription: loanDiscription, icon: UIImage(named: "loan3")!)
        
        
        let mortDiscription = NSMutableAttributedString()
        mortDiscription.append(stringFormatter(text: "ε0 = ", location: 1, length: 1, type: "sub"))
        let md = Help(name: "Mortgage Unit", discription: mortDiscription, icon: UIImage(named: "loan4")!)
        
        
        let exchDiscription = NSMutableAttributedString()
        exchDiscription.append(stringFormatter(text: "μ0 = ", location: 1, length: 1, type: "sub"))
       
        let ed = Help(name: "Currency Rate Converter", discription: exchDiscription, icon: UIImage(named: "loan5")!)
        
        helpViews += [cd, sd, ld, md, ed]
    }
      
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpViews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HelpViewCell
        cell.helpTitleText.text = helpViews[indexPath.row].getName()
        cell.helpDiscripText.attributedText = helpViews[indexPath.row].getDiscription()
        cell.helpImageView.image = helpViews[indexPath.row].getIcon()
        
        cell.isUserInteractionEnabled = false
        cell.contentView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00)
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00).cgColor
        cell.contentView.layer.masksToBounds = false
               
        return cell
    }
    
    
    func stringFormatter(text: String, location: Int = 0, length: Int = 0, type: String = "sup") -> NSMutableAttributedString {
        let font: UIFont? = UIFont(name: "Helvetica", size:20)
        let fontSupSub: UIFont? = UIFont(name: "Helvetica", size:10)
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: text, attributes: [.font:font!])
        attString.setAttributes([.font:fontSupSub!,.baselineOffset: type == "sup" ? 10 : -10], range: NSRange(location: location,length: length))
        return attString;
    }

    

}
