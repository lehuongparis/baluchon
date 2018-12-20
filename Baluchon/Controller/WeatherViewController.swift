//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by AMIMOBILE on 22/11/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var tempNYLabel: UILabel!
    @IBOutlet weak var condNYLabel: UILabel!
    
    @IBOutlet weak var tempParisLabel: UILabel!
    @IBOutlet weak var condParisLabel: UILabel!
    
    @IBOutlet weak var condCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.cityTextField.resignFirstResponder()
    }
    
    private var weatherService = WeatherService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService.getConditionCity(city: "newyork") { (tempNYCondition) in
            guard let tempNYCondition = tempNYCondition else {
                return
            }
            self.tempNYLabel.text = tempNYCondition.temp
            self.condNYLabel.text = tempNYCondition.text
        }

        weatherService.getConditionCity(city: "paris") { (tempParisCondition) in
            guard let tempParisCondition = tempParisCondition else {
                return
            }
            self.tempParisLabel.text = tempParisCondition.temp
            self.condParisLabel.text = tempParisCondition.text
        }
    }
    
    @IBAction func getTemTappedButton() {
        guard let city = cityTextField.text else {
            return
        }
        weatherService.getConditionCity(city: city) { (tempCityCondition) in
        guard let tempCityCondition = tempCityCondition else {
            return
        }
        self.tempCityLabel.text = tempCityCondition.temp
        self.condCityLabel.text = tempCityCondition.text
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        return true
    }
    
}
