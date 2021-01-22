//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeProgresssBar: UIProgressView!
    
    let eggTimes = ["Soft" : 1, "Medium" : 7, "Hard" : 12];
    
    var secondsRemaining = 60;
    var totalSeconds = 0;
    
    var timer = Timer();
    var player: AVAudioPlayer!

    @IBAction func touch(_ sender: UIButton) {
        timeProgresssBar.progress = 0.0;
        
        timer.invalidate();
        titleLabel.text = "How do you like your eggs?";
        let hardness = sender.currentTitle!;
        
        totalSeconds = eggTimes[hardness]! * 60;
        secondsRemaining = totalSeconds;
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func calculatePercentage() {
        let percentage = Float(totalSeconds - secondsRemaining) / Float(totalSeconds);
        print(percentage);
        timeProgresssBar.progress = percentage;
    }
    
    @objc func updateTimer() {
        calculatePercentage();
        if secondsRemaining > 0 {
            print (secondsRemaining);
            secondsRemaining -= 1;
        } else {
            titleLabel.text = "Done";
            playSound();
            timer.invalidate();
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}
