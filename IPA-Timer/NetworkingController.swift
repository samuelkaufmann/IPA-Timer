//
//  NetworkingController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 07.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import Foundation
import UIKit

class NetworkingController {
    
    struct IpaKandidat: Codable {
        let name: String
        let mail: String
        let ipa: ipa
        let first_expert: expert
        let second_expert: expert
    }
    
    struct ipa: Codable {
        let title: String
        let short_description: String
        let detail_description: String
    }
    
    struct expert: Codable {
        let name: String
        let mail: String
        let phone: String
    }
    
    func get(callback: ??) {
        let url = URL(string: "https://api.owncode.ch/ipa-timer")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            //Wenn dataTask ein Fehler wirft
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            //Prüfe Statuscode 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            //Wenn keine Daten zurückgekommen sind
            guard let data = data else {
                print("Error: missing data")
                return
            }
            // print(String(data: data, encoding: .utf8))
            do {
                let decoder = JSONDecoder()
                let ipaKandidat = try decoder.decode(IpaKandidat.self, from: data)
                print("ipa: \(ipaKandidat.ipa) Experte: \(ipaKandidat.first_expert)")
                return ipaKandidat
            }
            catch {
                print("Error: \(error.localizedDescription)")
                return nil
            }
            }.resume()
    }
}

