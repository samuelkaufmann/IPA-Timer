//
//  NetworkingController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 07.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import Foundation

class NetworkingController {
    
    func parseJSON() {
        let url = URL(string: "https://api.owncode.ch/ipa-timer")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            DispatchQueue.main.async {
                print(json)
            }
            
        }
        
        task.resume()
        
    }
    
}
