//
//  NetworkingController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 07.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import Foundation

class NetworkingController {
    
    func getJSON() {
        let url = URL(string: "https://api.owncode.ch/ipa-timer")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            guard error == nil else {
                print("Fehler beim laden der Quelle")
                return
            }
            
            guard let content = data else {
                print("Die Quelle leifert keine Daten zurück")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Die erhaltenen Daten können nicht angezeigt werden.")
                return
            }
            
            DispatchQueue.main.async {
                print(json)
            }
            
        }
        
        task.resume()
        
    }
    
}
