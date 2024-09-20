//
//  ViewController.swift
//  CatchRickApp
//
//  Created by Eren Elçi on 20.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet var imageView4: UIImageView!
    @IBOutlet var imageView5: UIImageView!
    @IBOutlet var imageView6: UIImageView!
    @IBOutlet var imageView7: UIImageView!
    @IBOutlet var imageView8: UIImageView!
    @IBOutlet var imageView9: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var timer = Timer()
    var counter = 0
    var skor = 0
    var rickArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(skor)"
        
        // HighScor Check
        let storedHigScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHigScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
            
        }
        
        if let newScore = storedHigScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        imageView.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true
        imageView5.isUserInteractionEnabled = true
        imageView6.isUserInteractionEnabled = true
        imageView7.isUserInteractionEnabled = true
        imageView8.isUserInteractionEnabled = true
        imageView9.isUserInteractionEnabled = true

        
        // algılayacı
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(tıklanmaFonksiyonu))
        
        // algılayıcıları verdik
        imageView.addGestureRecognizer(gestureRecognizer1)
        imageView2.addGestureRecognizer(gestureRecognizer2)
        imageView3.addGestureRecognizer(gestureRecognizer3)
        imageView4.addGestureRecognizer(gestureRecognizer4)
        imageView5.addGestureRecognizer(gestureRecognizer5)
        imageView6.addGestureRecognizer(gestureRecognizer6)
        imageView7.addGestureRecognizer(gestureRecognizer7)
        imageView8.addGestureRecognizer(gestureRecognizer8)
        imageView9.addGestureRecognizer(gestureRecognizer9)
        
        rickArray = [imageView,imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9]
        
        
        
        // Yarış Timer
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFonksiyonu), userInfo: nil, repeats: true)
        // Rick Timer
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideRick), userInfo: nil, repeats: true)
        hideRick()
    }
    
    @objc  func hideRick(){
        for item in rickArray {
            item.isHidden = true
        }
       let random = Int(arc4random_uniform(UInt32(rickArray.count - 1)))
        rickArray[random].isHidden = false
    }
    
   
    @objc func timerFonksiyonu(){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for item in rickArray {
                item.isHidden = true
            }
            
            //HighScore İşlemleri
            if self.skor > self.highScore {
                self.highScore = self.skor
                highScoreLabel.text = "Highscoreee: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            
            
            // Alert
            let alert = UIAlertController(title: "Time's up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.skor = 0
                self.scoreLabel.text = "Score: \(self.skor)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFonksiyonu), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideRick), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @objc func tıklanmaFonksiyonu(){
        skor += 1
        scoreLabel.text = "Score: \(skor)"
    }
    
    
    
    
}
