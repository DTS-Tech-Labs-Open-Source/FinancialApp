//
//  ComputeViewController.swift
//  FinancialApp
//
//  Created by Dilan Tharidu Sangeeth on 2/25/20.
//  Copyright © 2020 Dilan Tharidu Sangeeth. All rights reserved.
//

import UIKit

class ComputeViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
   
    var computeItemList = [Compute]()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        self.navigationController?.hidesBarsOnSwipe = false
          // Do any additional setup after loading the view, typically from a nib.
          genarateCompute()
      }
    
    func genarateCompute() {
        
        let compoundLoan = Compute(name: "Compund", cellIcon: UIImage(named: "loan1")!, cellColor: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00), cellId: "goToCompoundScene" )
        let saveing = Compute(name: "Saving", cellIcon: UIImage(named: "loan2")!, cellColor: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00), cellId: "goToSavingScene" )
        let norLoan = Compute(name: "Loan", cellIcon: UIImage(named: "loan3")!, cellColor: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00), cellId: "goToLoanScene" )
        let mortgage = Compute(name: "Mortgage", cellIcon: UIImage(named: "loan4")!, cellColor: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00), cellId: "goToMortgageScene" )
        let exchange = Compute(name: "Exchange Rate", cellIcon: UIImage(named: "loan5")!, cellColor: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00), cellId: "goToExchangeScene")
        
        computeItemList += [compoundLoan , saveing , norLoan , mortgage , exchange]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return computeItemList.count
       }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ComputeViewCell
        
        cell.computeText.text = computeItemList[indexPath.row].getname()
        cell.computeIcon.image = computeItemList[indexPath.row].getCellIcon()
        
        //Card(cell) styles
        cell.contentView.backgroundColor = computeItemList[indexPath.row].getCellColor()
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00).cgColor
        cell.contentView.layer.masksToBounds = false
        
        return cell
    }
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: computeItemList[indexPath.row].getCellId(), sender: self)
     }

}
