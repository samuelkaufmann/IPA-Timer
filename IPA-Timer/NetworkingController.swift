//
//  NetworkingController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 07.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//

import Foundation
import UIKit

struct IpaKandidat: Codable {
    let name: String
    let mail: String
    let ipa: ipa
    let first_expert: expert
    let second_expert: expert
}

// naming conventions: "Ipa"
struct ipa: Codable {
    let title: String
    let short_description: String
    let detail_description: String
}

// naming conventions: "Expert"
struct expert: Codable {
    let name: String
    let mail: String
    let phone: String
}

class NetworkingController {
    
    static func getIpaKandidat(completion: @escaping (IpaKandidat?) -> ()) {
        let url = URL(string: "https://api.owncode.ch/ipa-timer")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            // please always use only english language in projects even if team is 100% native language speaking
            //Wenn dataTask ein Fehler wirft
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            // please always use only english language in projects even if team is 100% native language speaking
            //Prüfe Statuscode 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            // please always use only english language in projects even if team is 100% native language speaking
            //Wenn keine Daten zurückgekommen sind
            guard let data = data else {
                print("Error: missing data")
                return
            }
            // please always use only english language in projects even if team is 100% native language speaking
            // print(String(data: data, encoding: .utf8))
            do {
                let decoder = JSONDecoder()
                let ipaKandidat = try decoder.decode(IpaKandidat.self, from: data)
                //print("ipa: \(ipaKandidat.ipa) Experte: \(ipaKandidat.first_expert)")
                completion(ipaKandidat)
            }
            catch {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            }.resume()
        
    }
}
