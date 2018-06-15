//
//  ViewController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 02.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var kandidat: IpaKandidat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NetworkingController.getIpaKandidat { (kandidat) in
            if let receivedKandidat = kandidat {
                self.kandidat = receivedKandidat
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
