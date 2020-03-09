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
    var computationType = Constants.COMPOUND_USER_DEFAULTS_KEY
    var icon: UIImage = UIImage(named: "loan1")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //coustom cell register
        tableView.dataSource = self
        tableView.delegate = self
        
        let cusCell = UINib(nibName: "HistoryGroupCellView", bundle: nil)
        tableView.register(cusCell, forCellReuseIdentifier: "customCell")
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
        let Hcell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! HistoryGroupCellViewController
        
        Hcell.commonInit(histories[indexPath.row].getHistoryIcon(), titel: histories[indexPath.row].getHistoryType(), id: "1", discription: histories[indexPath.row].getHistoryComputation())
        
        return Hcell
     }
     
    
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
    }
    

    @IBAction func deleteSaveHistory(_ sender: Any) {
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
