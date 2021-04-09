//
//  Bubble.swift
//  BubbleGameJenny
//
//  Created by Chengrong Zhan on 7/5/20.
//  Copyright © 2020 Yunhan Zhan. All rights reserved.
//


import UIKit

class Bubble: UIButton{
    
    var points:Double = 0
    
    var radius: UInt32 {
        return UInt32(UIScreen.main.bounds.width / 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //make bubble round
        self.layer.cornerRadius = CGFloat(radius)
        
        let percentage = Int(arc4random_uniform(100))
        
        switch percentage {
        case 0...39:
            self.backgroundColor = UIColor.red
            self.points = 1
        case 40...69:
            self.backgroundColor = UIColor.magenta
            self.points = 2
        case 70...84:
            self.backgroundColor = UIColor.green
            self.points = 5
        case 85...94:
            self.backgroundColor = UIColor.blue
            self.points = 8
        case 95...99:
            self.backgroundColor = UIColor.black
            self.points = 10
        default:
            print("error")
        }
        
    }
    
    func moveBubble() {
        
        //add animation for bubbles
        let bubbleMove = CASpringAnimation(keyPath: "transform.scale")
        bubbleMove.duration = 0.6
        bubbleMove.fromValue = 1
        bubbleMove.toValue = 0.8
        bubbleMove.repeatCount = 1
        bubbleMove.initialVelocity = 0.5
        bubbleMove.damping = 1
        bubbleMove.autoreverses = true
        
        layer.add(bubbleMove,forKey: nil)
        
    }
    
}

