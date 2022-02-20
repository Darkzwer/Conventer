//
//  ViewController.swift
//  Conventer
//
//  Created by Igor on 15/02/2022.
//  Copyright © 2022 DSoft. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var selectFromCurrencyBtn: UIButton!
    @IBOutlet weak var selectToCurrencyBtn: UIButton!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBAction func saveCurrencyDetail(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func selectedGame(segue:UIStoryboardSegue) {
        
        if let gamePickerViewController = segue.source as? CurrencyPickerVC,
            
            let selectedGame = gamePickerViewController.selectedGame {
            
            detailLabel.text = selectedGame
            
            game = selectedGame
            
            //selected game
        }
    }
    
    // MARK: - Properties
    var darkMode = false
    var fromCurrency = ""
    var toCurrency = ""
    var game:String = "testData"
    var player = ""
    var fetch = FetchJSON()
    
    var currencyCode: [String] = []
    var values: [Double] = []
    var currencyConvertRateDict: [String:Double] = [:]//to request via API
//    var currencyConvertRateDict = Data.CurrencyConvertRateDict //local request, to work, need to comment out the line named "fetchJSON()"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch.fetchJSON()
        setupView()
        //detailLabel.text = game
        fetchJSON()
        
        fromCurrencyTextField.addTarget(self, action: #selector(updateViews), for: .editingChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavePlayerDetail" {
            //player = nameTextField
        }
        if segue.identifier == "PickGame" {
            if let gamePickerViewController = segue.destination as? CurrencyPickerVC {
                gamePickerViewController.selectedGame = game
            }
        }
    }
    
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
                self.currencyConvertRateDict = Dictionary(uniqueKeysWithValues: zip(self.currencyCode, self.values))
                self.currencyConvertRateDict["BYN"] = nil
                self.currencyConvertRateDict["EUR"] = nil
                self.currencyConvertRateDict["RUB"] = nil
                self.currencyConvertRateDict["USD"] = nil
                self.currencyConvertRateDict["BYN 🇧🇾"] = 2.57
                self.currencyConvertRateDict["EUR 🇪🇺"] = 0.88
                self.currencyConvertRateDict["RUB 🇷🇺"] = 76.29
                self.currencyConvertRateDict["USD 🇺🇸"] = 1.0
                self.currencyConvertRateDict = self.currencyConvertRateDict.filter { $0.value < 85 }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    // MARK: - DarkMode and setupView funcs
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
            fromLabel.textColor = .black
            toLabel.textColor = .black
        }
    }
    
    func setupView() {
        fromLabel.backgroundColor = nil
        toLabel.backgroundColor = nil
    }
    
    // MARK: - IBActions
    @IBAction func darkModeButton(_ sender: UIBarButtonItem) {
        darkModeFunc()
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
    
    // MARK: - Dynamic update of entered values
    @objc func updateViews(input: Double) {
        if fromCurrencyTextField.text != "" {
            if let fromCurrencyRate = currencyConvertRateDict[fromCurrency], let toCurrencyRate = currencyConvertRateDict[toCurrency], let textFieldVal = fromCurrencyTextField.text, let val: Double = Double(textFieldVal){
                let usdVal = 1.0/fromCurrencyRate
                let toCurrencyVal = usdVal * toCurrencyRate
                let totalVal = val * toCurrencyVal
                self.toCurrencyTextField.text = String(totalVal)
            }
        } else if fromCurrencyTextField.text == "" {
            toCurrencyTextField.text = ""
        }
    }
    
    
    
}
