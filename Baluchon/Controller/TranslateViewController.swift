//
//  TraductionViewController.swift
//  Baluchon
//
//  Created by AMIMOBILE on 22/11/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    // MARK : - Oulets
    @IBOutlet weak var textFrTextField: UITextField!
    @IBOutlet weak var textEnLabel: UILabel!
    @IBOutlet weak var translateButton: UIButton!
    
    // MARK : - Let
    private let translateService = TranslateService()
    
    // MARK : - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentView()
    }
    
    // MARK : - Actions
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        textFrTextField.resignFirstResponder()
    }
    
    @IBAction func getTextEnButton() {
        updateTranslatedText()
    }
    
    // MARK : - Private functions
    private func presentView() {
        textEnLabel.layer.cornerRadius =  6.0
        textEnLabel.layer.backgroundColor = UIColor.white.cgColor
    }
    
    private func updateTranslatedText() {
        translateService.getTranslatedText(text: textFrTextField.text!) { (success, translatedText) in
            if success, let translatedText = translatedText {
                self.textEnLabel.text = translatedText
            } else {
                print("Oups, there's no result")
            }
        }
    }
}

// MARK: - Extension TextField
extension TranslateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFrTextField.resignFirstResponder()
        return true
    }
}
