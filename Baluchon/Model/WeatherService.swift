//
//  WeatherService.swift
//  Baluchon
//
//  Created by AMIMOBILE on 07/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import Foundation

// MARK : - Structs
struct ConditionCity: Decodable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let main: String
}

struct Main: Decodable {
    let temp: Double
}

class WeatherService {
    
    // MARK : - Vars
    private var task: URLSessionDataTask?
    private var weatherSession: URLSession
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
        }
    
    // MARK : - Functions
    func getConditionCity(city: String, callback : @escaping (ConditionCity?) -> Void) {
        guard let conditionCityUrl = getCityUrl(city: city) else { return }
     
        task = weatherSession.dataTask(with: conditionCityUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(nil)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(nil)
                    return
                }

                do {
                    let queryCityJson = try JSONDecoder().decode(ConditionCity.self, from: data)
                    callback(queryCityJson)

                } catch {
                    callback(nil)
                }
            }
        }
    task?.resume()
    }
    
    private func getCityUrl(city: String) -> URL? {
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil}
        guard let conditionCityUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&APPID=85137168b0d35695bae170138afe609d&units=metric") else { return nil }
        
        return conditionCityUrl
    }
    
}

