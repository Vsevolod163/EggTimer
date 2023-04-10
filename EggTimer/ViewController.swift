//
//  ViewController.swift
//  EggTimer
//
//  Created by Vsevolod Lashin on 10.04.2023.
//

import UIKit
import AVFoundation

final class ViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    
    @IBOutlet private var timerProgressView: UIProgressView!
    
    private var readyTime = 0
    private let eggTimes = ["Soft": 180, "Medium": 300, "Hard": 420]
    
    private var hardness = ""
    
    private var player: AVAudioPlayer!
    
    private var timer = Timer()
    private var secondsPassed = 0

    @IBAction private func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        hardness = sender.titleLabel?.text ?? ""
       
        readyTime = eggTimes[hardness] ?? 0
        
        timerProgressView.progress = 0.0
        secondsPassed = 0
        titleLabel.text = "\(hardness) - \((eggTimes[hardness] ?? 0) - secondsPassed) sec ⏰"
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerAction),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func timerAction() {
        secondsPassed += 1
        
        let progress = Float(secondsPassed) / Float(readyTime)
        
        timerProgressView.setProgress(Float(progress), animated: true)
        
        titleLabel.text = "\(hardness) - \((eggTimes[hardness] ?? 0) - secondsPassed) sec ⏰"

        if secondsPassed == readyTime {
            timer.invalidate()
            titleLabel.text = "Done!🥚"
            
            playSound(with: "alarm_sound")
        }
    }
    
    private func playSound(with sound: String) {
        let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}

