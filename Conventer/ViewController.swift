//
//  ViewController.swift
//  Conventer
//
//  Created by Igor on 15/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectFromCurrencyBtn: UIButton!
    @IBOutlet weak var selectToCurrencyBtn: UIButton!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyLbl: UILabel!
    @IBOutlet weak var convertBtn: UIButton!
    
    var currencyConvertRateDict = ["BYN 🇧🇾":2.65,"RUB 🇷🇺":68.6809355693,"EUR 🇪🇺":0.8826125331,"USD 🇺🇸":1.0]
    var fromCurrency = ""
    var toCurrency = ""
    
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

