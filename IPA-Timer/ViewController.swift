//
//  ViewController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 02.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //outlets for show the data
    //ipa data
    @IBOutlet weak var ipaTitleLabel: UILabel!
    @IBOutlet weak var ipaShorLabel: UILabel!
    @IBOutlet weak var ipaDetailLabel: UILabel!
    //first-expert data
    @IBOutlet weak var firstExpertLabel: UILabel!
    @IBOutlet weak var firstExpertMailLabel: UILabel!
    @IBOutlet weak var firstExpertPhoneLabel: UILabel!
    //second-expert data
    @IBOutlet weak var secondExpertLabel: UILabel!
    @IBOutlet weak var secondExpertMailLabel: UILabel!
    @IBOutlet weak var secondExpertPhoneLabel: UILabel!
    
    //define placeholder for all data
    var kandidat: IpaKandidat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let utterance = AVSpeechUtterance(string: "Deine I P A Daten werden geladen, Moment bitte")
        utterance.voice = AVSpeechSynthesisVoice(language: "de")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        //trigger methode for get the datas form api
        NetworkingController.getIpaKandidat { (kandidat) in
            //check if dataplaceholder exists
            if let receivedKandidat = kandidat {
                //put everything in the kandidat-placeholder
                self.kandidat = receivedKandidat
            }
            //put all data at the right label in the view
            self.ipaTitleLabel.text = kandidat!.ipa.title
            self.ipaShorLabel.text = kandidat?.ipa.short_description
            self.ipaDetailLabel.text = kandidat?.ipa.detail_description
            self.firstExpertLabel.text = kandidat?.first_expert.name
            self.firstExpertMailLabel.text = kandidat?.first_expert.mail
            self.firstExpertPhoneLabel.text = kandidat?.first_expert.phone
            self.secondExpertLabel.text = kandidat?.second_expert.name
            self.secondExpertMailLabel.text = kandidat?.second_expert.mail
            self.secondExpertPhoneLabel.text = kandidat?.second_expert.phone
            //print data for debug
            //print(kandidat?.ipa)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
