//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by AMIMOBILE on 22/11/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK : - Outlets
    @IBOutlet weak var tempNYLabel: UILabel!
    @IBOutlet weak var condNYLabel: UILabel!
    @IBOutlet weak var tempParisLabel: UILabel!
    @IBOutlet weak var condParisLabel: UILabel!
    @IBOutlet weak var condCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    
    // MARK : - var
    private let weatherService = WeatherService()
    
    // MARK : - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateTempNY()
        self.updateTempParis()
    }
    
    // MARK : - Actions
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        self.cityTextField.resignFirstResponder()
    }
    
    @IBAction func getTemTappedButton() {
        updateTempCity()
    }

    // MARK : - Private functions
    private func updateTempNY() {
        weatherService.getConditionCity(city: "newyork") { (tempNYCondition) in
            guard let tempNYCondition = tempNYCondition else {
                return
            }
            print(tempNYCondition)
            self.tempNYLabel.text = String(tempNYCondition.mainCity.main.temp)
            self.condNYLabel.text = tempNYCondition.weatherCity.weather.description
        }
    }
    
    private func updateTempParis() {
        weatherService.getConditionCity(city: "paris") { (tempParisCondition) in
            guard let tempParisCondition = tempParisCondition else {
                return
            }
            self.tempParisLabel.text = String(tempParisCondition.mainCity.main.temp)
            self.condParisLabel.text = tempParisCondition.weatherCity.weather.description
        }
    }
    
    private func updateTempCity() {
        guard let city = cityTextField.text else {
            return
        }
        weatherService.getConditionCity(city: city) { (tempCityCondition) in
            guard let tempCityCondition = tempCityCondition else {
                return
            }
            self.tempCityLabel.text = String(tempCityCondition.mainCity.main.temp)
            self.condCityLabel.text = tempCityCondition.weatherCity.weather.description
        }
    }
}


// MARK : - UITextField
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        return true
    }
    
}
