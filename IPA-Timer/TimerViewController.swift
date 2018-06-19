//
//  TimerViewController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 15.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import UIKit
import AudioToolbox

class TimerViewController: UIViewController {

    var seconds = 1200
    var timer = Timer()
    var isTimerRunnung = false
    var resumeTapped = false
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBAction func startStopButton(_ sender: Any) {
        if isTimerRunnung == false {
            runTimer()
            isTimerRunnung = true
        } else {
            pauseTimer()
            isTimerRunnung = false
            resumeTapped = true
        }
    }
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        seconds = 1200
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunnung = false
        resumeTapped = false
    }
    
    func pauseTimer() {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }

    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            for _ in 1...10 {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                sleep(1)
            }
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
        if seconds == 900 || seconds == 600 || seconds == 300 {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
