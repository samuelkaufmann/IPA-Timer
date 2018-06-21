//
//  TimerViewController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 15.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

//import all needed packages
import UIKit
import AudioToolbox
import AVFoundation

class TimerViewController: UIViewController {
    
    //define duration, timer instance and some orientations variables
    var seconds = 1200
    var timer = Timer()
    var isTimerRunnung = false
    var resumeTapped = false
    
    //define outlets and actions
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBAction func startStopButton(_ sender: Any) {
        if isTimerRunnung == false {
            //start timer
            runTimer()
            startStopButton.setTitle("Pause", for: .normal)
            isTimerRunnung = true
        } else {
            //pause timer
            pauseTimer()
            startStopButton.setTitle("Start", for: .normal)
            isTimerRunnung = false
            resumeTapped = true
        }
    }
    @IBAction func resetButton(_ sender: Any) {
        //reset timer back to 1200s
        timer.invalidate()
        seconds = 1200
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunnung = false
        resumeTapped = false
        startStopButton.setTitle("Start", for: .normal)
    }
    
    //define timer pause methode
    func pauseTimer() {
        //check if timeris resumed/running or not
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
        } else {
            runTimer()
            self.resumeTapped = false
        }

    }
    
    //define run timer methode
    func runTimer() {
        //create new instance of timer and configure it
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    //define update timer label methode
    @objc func updateTimer() {
        //check specific values at the timer to triger actions every 300s and stop by 0s
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
        //let device vibrate every 300s and by 0s
        if seconds == 900 || seconds == 600 || seconds == 300 {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
    
    //define string formating methode to build time in mm:ss
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = 1200
        //initiate first responder for easteregg
        timerLabel.text = timeString(time: TimeInterval(seconds))
        self.canBecomeFirstResponder
    }
    
    //first responder value
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    //detecting for shake gesture
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            //say something
            let utterance = AVSpeechUtterance(string: "Hör auf mich zu schütteln nur weil du nervös bist. Atmen wäre besser für dich!")
            utterance.voice = AVSpeechSynthesisVoice(language: "de")
            utterance.rate = 0.5
            
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
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
