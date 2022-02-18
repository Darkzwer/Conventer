//
//  DarkModeUserDefaults.swift
//  Conventer
//
//  Created by Igor on 18/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import Foundation

enum Theme: Int {
    case device
    case light
    case dark
    
//    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
//        switch self {
//        case .device:
//            return.unspecified
//        case .light:
//            return.light
//        case .dark:
//            return.dark
//        }
//    }
}

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
