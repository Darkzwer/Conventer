//
//  FetchJSON.swift
//  Conventer
//
//  Created by Igor on 20/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import Foundation

class FetchJSON {
    
    // MARK: - Properties
    var currencyCode: [String] = []
    var values: [Double] = []
    
    
    // MARK: - Method
    func fetchJSON() {
        guard let url = URL(string: Data.APIUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let safeData = data else { return }
            
            do {
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                self.currencyCode.append(contentsOf: results.rates.keys)//Key
                self.values.append(contentsOf: results.rates.values)//Value
                //self.newDict = Dictionary(uniqueKeysWithValues: zip(self.currencyCode, self.values))
                //print(self.newDict)
            } catch {
                print(error)
            }
        }.resume()
    }
}
