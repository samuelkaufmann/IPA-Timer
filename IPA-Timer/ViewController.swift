//
//  ViewController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 02.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var ipaTitleLabel: UILabel!
    @IBOutlet weak var ipaShorLabel: UILabel!
    @IBOutlet weak var ipaDetailLabel: UILabel!
    //First-Expert
    
    @IBOutlet weak var firstExpertLabel: UILabel!
    @IBOutlet weak var firstExpertMailLabel: UILabel!
    @IBOutlet weak var firstExpertPhoneLabel: UILabel!
    //Second-Expert
    @IBOutlet weak var secondExpertLabel: UILabel!
    @IBOutlet weak var secondExpertMailLabel: UILabel!
    @IBOutlet weak var secondExpertPhoneLabel: UILabel!
    
    
    var kandidat: IpaKandidat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NetworkingController.getIpaKandidat { (kandidat) in
            if let receivedKandidat = kandidat {
                self.kandidat = receivedKandidat
            }
            self.ipaTitleLabel.text = kandidat!.ipa.title
            self.ipaShorLabel.text = kandidat?.ipa.short_description
            self.ipaDetailLabel.text = kandidat?.ipa.detail_description
            
            self.firstExpertLabel.text = kandidat?.first_expert.name
            self.firstExpertMailLabel.text = kandidat?.first_expert.mail
            self.firstExpertPhoneLabel.text = kandidat?.first_expert.phone
            
            self.secondExpertLabel.text = kandidat?.second_expert.name
            self.secondExpertMailLabel.text = kandidat?.second_expert.mail
            self.secondExpertPhoneLabel.text = kandidat?.second_expert.phone
            print(kandidat?.ipa)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
