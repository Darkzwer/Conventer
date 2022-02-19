//
//  Data.swift
//  Conventer
//
//  Created by Igor on 15/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import Foundation

enum Data {
    static var APIUrl = "https://api.fixer.io/latest?base=USD"//В планах добавить но не работает без API Key
    static var CurrencyConvertRateDict = ["BYN 🇧🇾":2.65,"RUB 🇷🇺":68.6809355693,"EUR 🇪🇺":0.8826125331,"USD 🇺🇸":1.0]
    static var сurrencies = ["BYN 🇧🇾","RUB 🇷🇺","EUR 🇪🇺","USD 🇺🇸"]
}
