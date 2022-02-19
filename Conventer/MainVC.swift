//
//  ViewController.swift
//  Conventer
//
//  Created by Igor on 15/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var selectFromCurrencyBtn: UIButton!
    @IBOutlet weak var selectToCurrencyBtn: UIButton!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var detailLabel: UILabel!
    @IBAction func darkModeButton(_ sender: UIBarButtonItem) {
        darkModeFunc()
    }
    @IBAction func saveCurrencyDetail(segue:UIStoryboardSegue) {
    }
    
    var darkMode = false
    var currencyConvertRateDict = Data.CurrencyConvertRateDict
    var fromCurrency = ""
    var toCurrency = ""
    var game:String = "testData"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //detailLabel.text = game
    }
    
    @IBAction func selectFromCurrencyBtnAxn(_ sender: UIButton) {
        let sheet = UIAlertController(title: "From Currency is", message: nil, preferredStyle: .actionSheet)
        for key in self.currencyConvertRateDict.keys{
            let action = UIAlertAction(title: key, style: .default) { (action) in
                self.fromCurrency = key
                self.selectFromCurrencyBtn.setTitle(key, for: .normal)
                self.toCurrencyTextField.text = ""
                
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
        let sheet = UIAlertController(title: "To Currency is", message: nil, preferredStyle: .actionSheet)
        for key in self.currencyConvertRateDict.keys{
            let action = UIAlertAction(title: key, style: .default) { (action) in
                self.toCurrency = key
                self.selectToCurrencyBtn.setTitle(key, for: .normal)
                self.toCurrencyTextField.text = ""
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
            self.toCurrencyTextField.text = String(totalVal)
        }
    }
    
    func darkModeFunc() {
        if darkMode == false {
            darkMode = true
            view.backgroundColor = .black
            selectToCurrencyBtn.backgroundColor = .black
            selectFromCurrencyBtn.tintColor = .white
            selectToCurrencyBtn.tintColor = .white
            selectFromCurrencyBtn.backgroundColor = .black
            fromCurrencyTextField.backgroundColor = .white
            toCurrencyTextField.backgroundColor = .white
            convertBtn.backgroundColor = .white
            fromLabel.textColor = .white
            toLabel.textColor = .white
            
        } else if darkMode == true {
            darkMode = false
            view.backgroundColor = .white
            selectToCurrencyBtn.backgroundColor = .white
            selectFromCurrencyBtn.tintColor = .link
            selectToCurrencyBtn.tintColor = .link
            selectFromCurrencyBtn.backgroundColor = .white
            selectToCurrencyBtn.backgroundColor = .white
            fromCurrencyTextField.backgroundColor = .white
            toCurrencyTextField.backgroundColor = .white
            convertBtn.backgroundColor = .systemTeal
            fromLabel.textColor = .black
            toLabel.textColor = .black
        }
    }
    
    func setupView() {
        fromLabel.backgroundColor = nil
        toLabel.backgroundColor = nil
    }
    
    
    
}
