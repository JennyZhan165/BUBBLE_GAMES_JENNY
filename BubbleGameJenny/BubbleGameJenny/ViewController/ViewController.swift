//
//  ViewController.swift
//  BubbleGameJenny
//
//  Created by Chengrong Zhan on 7/5/20.
//  Copyright © 2020 Yunhan Zhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // add imgae to the screen
        //**Download from Google, no copyright**//
        BubblePop.image = UIImage(named: "images (2)")
    }
    
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var BubblePop: UIImageView!
    @IBAction func NewGame(_ sender: UIButton) {
        
        textName = NameText.text!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewGameViewController{
            
            //pass the 'playerName' to next NewGameViewController
            vc.finalName = textName
            
        }
    }

}

