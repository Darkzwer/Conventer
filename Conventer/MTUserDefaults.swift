//
//  MTUserDefaults.swift
//  Conventer
//
//  Created by Igor on 16/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import Foundation

struct MTUserDefaults {
    static var shared = UserDefaults()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .device
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
            
        }
    }
}
