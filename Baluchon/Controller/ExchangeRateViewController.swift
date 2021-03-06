//
//  ExchangeRateViewController.swift
//  Baluchon
//
//  Created by AMIMOBILE on 22/11/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    // MARK : - Oulets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var amountUSDLabel: UILabel!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var getAmountButton: UIButton!
    
    // MARK : Vars
    var symbol = [String]()
    var symbolSelected = String()
    
    private let exchangeRateService = ExchangeRateService()
    
    // MARK : - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentView()
        self.getCurrency()
    }
    
    // MARK : - Actions
    @IBAction func tappedCurrencyButton() {
        currencyPickerView.isHidden = false
    }
    
    @IBAction func tappedGetAmount() {
        getSymbolSelected()
        updateAmount()
    }
    
    // MARK : - Private Function
    private func presentView() {
        amountUSDLabel.layer.cornerRadius = 6.0
        amountUSDLabel.layer.backgroundColor = UIColor.white.cgColor
        activityIndicator.isHidden = true
        currencyPickerView.isHidden = true
    }
    
    private func getCurrency() {
        exchangeRateService.getCurrency { (success, symbols) in
            if success, let symbols = symbols {
                self.getSortedSymbols(symbols: symbols)
            } else {
                self.presentAlert()
            }
        }
    }
    
    private func updateAmount() {
        exchangeRateService.getRate(symbol: symbolSelected) { (success, rate) in
            if success, let rate = rate {
                guard let doubleAmount = Double(self.amountTextField.text!) else { return }
                let rate = (doubleAmount * rate * 1000).rounded() / 1000
                self.amountUSDLabel.text = String(rate)
            } else {
                self.presentAlert()
            }
        }
    }
    
    private func getSortedSymbols(symbols: [String]) {
        let sortedSymbols = symbols.sorted{$0 < $1}
        self.symbol = sortedSymbols
    }
    
    private func getSymbolSelected() {
        let currencyIndex = currencyPickerView.selectedRow(inComponent: 0)
        self.symbolSelected = symbol[currencyIndex]
    }
    
    // MARK : - Alert
    private func presentAlert() {
       let alertVC = UIAlertController(title: "Error", message: "No currency available", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

 // MARK: - PickerView
extension ExchangeRateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symbol.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symbol[row]
    }
}

// MARK: - TextField
extension ExchangeRateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountTextField.resignFirstResponder()
        return true
    }
}
