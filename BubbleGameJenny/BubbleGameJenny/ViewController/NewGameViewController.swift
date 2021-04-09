//
//  NewGameViewController.swift
//  BubbleGameJenny
//
//  Created by Chengrong Zhan on 7/5/20.
//  Copyright © 2020 Yunhan Zhan. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {

    var finalName = ""
    
    var seconds = 60
    var num_bubbles = 15
    
    @IBOutlet weak var Label: UILabel! // Label shown user name
    @IBOutlet weak var SettingTime: UILabel! //make slider time updated
    @IBOutlet weak var SettingBubble: UILabel! //make num_of_bubbles updated
    
    override func viewDidLoad() {
        
        //set the nameLabel to what the user entered
        Label.text = finalName
        super.viewDidLoad()

    }
    
    @IBAction func TimeSlider(_ sender: UISlider) {
        
        //default time is 60
        seconds = Int(sender.value)
        
        //update the timeSlider Label
        SettingTime.text = String(seconds)
        
    }
    
    @IBAction func BubbleSlider(_ sender: UISlider) {
        
        //default num_of_bubbles is 15
        num_bubbles = Int(sender.value)
        
        //update the num_of_bubble slider Label
        SettingBubble.text = String(num_bubbles)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let T = segue.destination as? GameViewController, let B = segue.destination as? GameViewController, let name = self.Label.text {
            
            //pass time, num_of_bubbles to next GameViewController
            T.time = seconds
            B.numberOfBubble = num_bubbles
            segue.destination.navigationItem.title = name
            
            }
        else {
            print("**ERROR**")
        }

    }

}
