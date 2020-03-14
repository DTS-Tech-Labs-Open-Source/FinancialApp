//
//  HistoryViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 2/25/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate  {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var histories = [SavedHistory]()
    var computationType : String = Constants.COMPOUND_USER_DEFAULTS_KEY
    var icon: UIImage = UIImage(named: "loan1")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // generate the defualt history view
        generateHistory(type: computationType, icon: icon)
        DispatchQueue.main.async { self.tableView.reloadData() }
        
        if histories.count > 0 {
            self.navigationItem.rightBarButtonItem!.isEnabled = true;
        }else{
           self.navigationItem.rightBarButtonItem!.isEnabled = false;
        }
    }
    
    
      func numberOfSectionsInTableView(tableView: UITableView) -> Int {
          return 1
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if histories.count == 0 {
            self.tableView.triggerEmptyMessage("No saved conversions found")
        } else {
            self.tableView.restore()
        }
                
        return histories.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Hcell = tableView.dequeueReusableCell(withIdentifier: "hCell", for: indexPath) as! SaveHistoryViewCellController
        
        Hcell.cellId.text = "1"
        Hcell.cellImage.image = histories[indexPath.row].getHistoryIcon()
        Hcell.cellTitel.text = histories[indexPath.row].getHistoryType()
        Hcell.cellDiscription.text = histories[indexPath.row].getHistoryComputation()
        
        // Card(cell) styles
        Hcell.isUserInteractionEnabled = false
        Hcell.contentView.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00)
        Hcell.contentView.layer.cornerRadius = 10.0
        Hcell.contentView.layer.borderWidth = 1.0
        Hcell.contentView.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00).cgColor
        Hcell.contentView.layer.masksToBounds = false
        
        return Hcell
     }
     
    
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        
        switch segmentView.selectedSegmentIndex {
        case 0:
            computationType = Constants.COMPOUND_USER_DEFAULTS_KEY
            icon = UIImage(named: "loan1")!
        case 1:
            computationType = Constants.SAVEING_USER_DEFAULTS_KEY
            icon = UIImage(named: "loan2")!
        case 2:
            computationType = Constants.LOAN_USER_DEFAULTS_KEY
            icon = UIImage(named: "loan3")!
        case 3:
            computationType = Constants.MORTGAGE_USER_DEFAULTS_KEY
            icon = UIImage(named: "loan4")!
        case 4:
            computationType = Constants.EXCHANGE_RATE_USER_DEFAULTS_KEY
             icon = UIImage(named: "loan5")!
        default:
            break
        }
        
        // generate the gistory and reload the table
        generateHistory(type: computationType, icon: icon)
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    

    @IBAction func deleteSaveHistory(_ sender: Any) {
        if histories.count > 0 {
            UserDefaults.standard.set([], forKey: computationType)
            
            let alert = UIAlertController(title: "Success", message: "The saved conversions were successfully deleted!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            // refetch hitory and reload table
            generateHistory(type: computationType, icon: icon)
            DispatchQueue.main.async{ self.tableView.reloadData() }
            
            if histories.count > 0 {
                self.navigationItem.rightBarButtonItem!.isEnabled = true;
            }else{
                self.navigationItem.rightBarButtonItem!.isEnabled = false;
            }
        }
    }
    
    
    func generateHistory(type: String, icon: UIImage) {
        histories = []
        let historyList = UserDefaults.standard.value(forKey: computationType) as? [String]
        
        if historyList?.count ?? 0 > 0 {
            for item in historyList! {
                let history = SavedHistory(type: type, icon: icon, comutation: item)
                histories += [history]
            }
        }
    }
}
