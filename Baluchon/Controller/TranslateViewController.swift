//
//  TraductionViewController.swift
//  Baluchon
//
//  Created by AMIMOBILE on 22/11/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var textFrTextField: UITextField!
    @IBOutlet weak var textEnLabel: UILabel!
    @IBOutlet weak var translateButton: UIButton!
    private let translateService = TranslateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEnLabel.layer.cornerRadius =  6.0
        textEnLabel.layer.backgroundColor = UIColor.white.cgColor
    }
    
    @IBAction func getTextEnButton() {
        translateService.getTranslatedText(text: textFrTextField.text!) { (success, translatedText) in
            if success, let translatedText = translatedText {
                self.updateTranslatedText(text: translatedText)
            } else {
                print("error")
            }
        }
    }
    
    private func updateTranslatedText(text: String) {
        textEnLabel.text = text
    }
    
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        textFrTextField.resignFirstResponder()
    }
    
}

// MARK: - Extension TextField
extension TranslateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFrTextField.resignFirstResponder()
        return true
    }
    
}
