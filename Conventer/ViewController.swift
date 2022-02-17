//
//  ViewController.swift
//  Conventer
//
//  Created by Igor on 15/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import UIKit

enum Theme: Int {
    case device
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .device:
            return.unspecified
        case .light:
            return.light
        case .dark:
            return.dark
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var selectFromCurrencyBtn: UIButton!
    @IBOutlet weak var selectToCurrencyBtn: UIButton!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyLbl: UILabel!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    @IBAction func darkModeSwitch(_ sender: UIBarButtonItem) {
        if darkMode == false {
            darkMode = true
            view.backgroundColor = .black
            selectToCurrencyBtn.backgroundColor = .white
            selectFromCurrencyBtn.backgroundColor = .white
            fromCurrencyTextField.backgroundColor = .white
            toCurrencyLbl.backgroundColor = .white
            convertBtn.backgroundColor = .white
            
            fromLabel.textColor = .white
            fromLabel.text = "From"
            toLabel.textColor = .white
            toLabel.text = "To"
            
        } else if darkMode == true {
            darkMode = false
            view.backgroundColor = .white
            selectToCurrencyBtn.backgroundColor = .white
            selectFromCurrencyBtn.backgroundColor = .white
            selectToCurrencyBtn.backgroundColor = .white
            fromCurrencyTextField.backgroundColor = .white
            toCurrencyLbl.backgroundColor = .white
            convertBtn.backgroundColor = .systemTeal
            
            fromLabel.textColor = .black
            fromLabel.text = "From"
            toLabel.textColor = .black
            toLabel.text = "To"
            //rightBarButton.image = UIImage(named: "sun.max")
        }
    }
    
    var darkMode = false
    
    var currencyConvertRateDict = ["BYN 🇧🇾":2.65,"RUB 🇷🇺":68.6809355693,"EUR 🇪🇺":0.8826125331,"USD 🇺🇸":1.0]
    var fromCurrency = ""
    var toCurrency = ""
    
    private var segmentedidControl: UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: ["Device", "Light", "Dark"])
        segmentedControl.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor(named: "otherColor")
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }
    
    @objc private func segmentChanged() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectFromCurrencyBtnAxn(_ sender: UIButton) {
        let sheet = UIAlertController(title: "Select From Currency", message: nil, preferredStyle: .actionSheet)
        for key in self.currencyConvertRateDict.keys{
            let action = UIAlertAction(title: key, style: .default) { (action) in
                self.fromCurrency = key
                self.selectFromCurrencyBtn.setTitle(key, for: .normal)
                self.toCurrencyLbl.text = ""
                
            }
            sheet.addAction(action)
        }
        if let popoverPresentationController = sheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
        self.present(sheet, animated: true, completion: nil)
        
    }
    
    @IBAction func selectToCurrencyBtnAxn(_ sender: UIButton) {
        let sheet = UIAlertController(title: "Select To Currency", message: nil, preferredStyle: .actionSheet)
        for key in self.currencyConvertRateDict.keys{
            let action = UIAlertAction(title: key, style: .default) { (action) in
                self.toCurrency = key
                self.selectToCurrencyBtn.setTitle(key, for: .normal)
                self.toCurrencyLbl.text = ""
            }
            sheet.addAction(action)
        }
        if let popoverPresentationController = sheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = sender.bounds
        }
        self.present(sheet, animated: true, completion: nil)
    }
    
    @IBAction func convertBtnAxn(_ sender: Any) {
        if let fromCurrencyRate = currencyConvertRateDict[fromCurrency], let toCurrencyRate = currencyConvertRateDict[toCurrency], let textFieldVal = fromCurrencyTextField.text, let val: Double = Double(textFieldVal){
            let usdVal = 1.0/fromCurrencyRate
            let toCurrencyVal = usdVal * toCurrencyRate
            let totalVal = val * toCurrencyVal
            self.toCurrencyLbl.text = String(totalVal)
        }
    }
    
    
}
