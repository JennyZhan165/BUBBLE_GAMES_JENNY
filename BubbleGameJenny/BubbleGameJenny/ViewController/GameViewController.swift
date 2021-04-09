//
//  GameViewController.swift
//  BubbleGameJenny
//
//  Created by Chengrong Zhan on 7/5/20.
//  Copyright © 2020 Yunhan Zhan. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var time = Int()
    var timer: Timer?
    
    var previousRankingDictionary: Dictionary? = [String : Double]()
    var rankingDictionary = [String : Double]()
    var sortedHighScoreArray = [(key: String, value: Double)]()
    
    var bubble = Bubble()
    var bubbleArray = [Bubble]()
    var numberOfBubble = Int()
    
    var lastBubbleValue: Double = 0
    var score: Double = 0
    var playerName: String = ""
    
    var count:Int = 3
    
    //get the screen size
      var screenWidth: UInt32 {
             return UInt32(UIScreen.main.bounds.width)
      }
      var screenHeight: UInt32 {
             return UInt32(UIScreen.main.bounds.height)
      }
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighScoreLabel: UILabel!
    @IBOutlet weak var C: UILabel!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        C.isHidden = true // hide the countdown label first
        
        TimeLabel.text = String(time) // set the timelabel to what the user entered
        
        previousRankingDictionary = UserDefaults.standard.dictionary(forKey: "ranking") as? Dictionary<String,Double>
        
        if previousRankingDictionary != nil{
            
            //update the rankingDictionary and sorted it to array from highest score to lowest score
            rankingDictionary = previousRankingDictionary!
            sortedHighScoreArray = rankingDictionary.sorted(by: {$0.value > $1.value})
            
        }
        
    }
    
    @IBOutlet weak var StartBTN: UIButton!
    
    @IBAction func Play(_ sender: UIButton) {
        
        //every seconds the timer will -1 and three following function will be called
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
        
        //StartGame button is hidden and countdown button will show
        StartBTN.isHidden = true
        C.isHidden = false
        
    }
    
    func saveHighScore(){
        
        //get the playerName from navigationItem bar
        let playerName = self.navigationItem.title!
        
        //update rankingDictioanary and save it as set
        rankingDictionary.updateValue(score, forKey: "\(playerName)")
        UserDefaults.standard.set(rankingDictionary,forKey: "ranking")
    
    }
    
   @objc func countdown(){
    
    if count > 0{
        
        C.text = String(count)
        count = count - 1
        
    }else if count == 0{
        
        //if countown is 0, the game is started so hide the label time contiue running
        C.isHidden = true
        
        self.TimerRunning()
        self.RemoveBubble()
        self.CreateBubble()
        }
        
    }
    
    @objc func TimerRunning(){
        
        //counting down the timer
        self.time = time - 1
        
        //update the timeLabel
        self.TimeLabel.text = String(time)
        
        // stop the game when the time = 0
        if (time == 0){
            
            timer!.invalidate() //stop the timer
            saveHighScore() //update the rankingDictioanry
            
            //navigate to highScore page
            let dest = self.storyboard?.instantiateViewController(withIdentifier: "myTableViewController") as! myTableViewController
            self.navigationController?.pushViewController(dest, animated: true)
            
            }
        }
    
    //shuffle the bubbles
    @objc func RemoveBubble(){
        
        var i = 0
        
        while i < bubbleArray.count {
            
             // if more than 40%
            if  40 > arc4random_uniform(100) {
                
               //remove from superview
                bubbleArray[i].removeFromSuperview()
                
                //remove from array
                bubbleArray.remove(at: i)
                
                //loop
                i = i + 1
            }
        }
        
    }
    
    @objc func CreateBubble() {
        
        let numberOfCreating = arc4random_uniform(UInt32(numberOfBubble - bubbleArray.count)) + 1
        
        var i = 0
        while ( i < numberOfCreating){
            
        bubble = Bubble()
        
        //create the frame for bubble
        bubble.frame = CGRect(x: CGFloat(10 + arc4random_uniform(screenWidth - 2 * bubble.radius - 20)), y: CGFloat(160 + arc4random_uniform(screenHeight - 2 * bubble.radius - 250)), width: CGFloat(2 * bubble.radius), height: CGFloat(2 * bubble.radius))
        
        //check overlap
        if  isOverlapped(bubbleToCreate: bubble) == false{
           
            //set onclick method
            bubble.addTarget(self, action: #selector(TapBubble), for: UIControl.Event.touchUpInside)
            
            self.view.addSubview(bubble)
            
            //Animate
            bubble.moveBubble()
            
            //loop
            i = 1 + i
            bubbleArray = bubbleArray + [bubble]
            
            }
        }
    }
    
    //check if the created bubble is overlapped
    
    func isOverlapped(bubbleToCreate: Bubble) -> Bool {
        for currentIndex in bubbleArray {
            
            if bubbleToCreate.frame.intersects(currentIndex.frame) {
                
                return true
                
            }
        }
        return false
    }
    
    //tap bubble, bubble disappear and earn scores
    @objc func TapBubble(_ sender: Bubble){
        
        //remove bubble from screen
        sender.removeFromSuperview()
        
        //checking the combo
        if lastBubbleValue == sender.points{
            
            score += Double(sender.points) * 1.5
            
        }
        else{
            
            score += Double(sender.points)
        
        }
        
        //update the last bubble value
        lastBubbleValue = sender.points
        
        //update current score
        ScoreLabel.text = String(score)
        
        //check and update high score
        if previousRankingDictionary == nil{
            
            HighScoreLabel.text = "\(score)"
            
        }
        else if sortedHighScoreArray[0].value < score{
            
            HighScoreLabel.text = "\(score)"
            
        }
        else if sortedHighScoreArray[0].value >= score{
            
            HighScoreLabel.text = "\(sortedHighScoreArray[0].value)"
            
        }
        
    }

}
