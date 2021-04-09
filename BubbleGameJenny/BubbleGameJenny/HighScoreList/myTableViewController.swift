	//
//  myTableViewController.swift
//  BubbleGameJenny
//
//  Created by Chengrong Zhan on 18/5/20.
//  Copyright © 2020 Yunhan Zhan. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {
        
    var Array = [(key: String, value: Double)]()
    var rankingDictionary = [String : Double]()
    
    @IBAction func RestartGame(_ sender: Any) {
        
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(dest, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingDictionary = (UserDefaults.standard.dictionary(forKey: "ranking") as! [String: Double]?)!
        
        let sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
     
        for(key, value) in sortedHighScoreArray{
        
        //add pairs to array
        Array.append((key,value))
        
        //print("\(key) \(value)")

        }
        
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return the number of rows, top 5 playerName and score
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let v = Array[indexPath.row]
        
        cell.name.text = v.key //get the playerName from the array
        cell.score.text = String(v.value) //get the playerScore from the array
        
        return cell
    }

}
