//
//  NetworkingController.swift
//  IPA-Timer
//
//  Created by Samuel Kaufmann on 07.06.18.
//  Copyright © 2018 Samuel Kaufmann. All rights reserved.
//
//import of used packages
import Foundation
import UIKit

//definition of structure from the data with codable
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
        //url definition for the json
        let url = URL(string: "https://kaufmann.informatics.ch/project/kandidat/k1")
        //create urlsession for async requests
        URLSession.shared.dataTask(with: url!) { data, response, error in
            //if urlsesion failed
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            //check if statuscode of request is 200
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            //if there was no datafound
            guard let data = data else {
                print("Error: missing data")
                return
            }
            //printing data for debug
            //print(String(data: data, encoding: .utf8))
            do {
                //new instance of decoder for decode the data
                let decoder = JSONDecoder()
                //decode everything
                let ipaKandidat = try decoder.decode(IpaKandidat.self, from: data)
                //print data for debug
                //print("ipa: \(ipaKandidat.ipa) Experte: \(ipaKandidat.first_expert)")
                completion(ipaKandidat)
            }
            //if there was something went wrong by decoding
            catch {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            //execute request
            }.resume()
        
    }
}
