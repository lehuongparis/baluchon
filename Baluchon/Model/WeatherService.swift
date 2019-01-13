//
//  WeatherService.swift
//  Baluchon
//
//  Created by AMIMOBILE on 07/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import Foundation

struct Condition: Decodable {
    let weatherCity: Weather
    let mainCity: Main
}

struct Weather: Decodable {
    let weather: [Description]
}

struct Description: Decodable {
    let description: String
}

struct Main: Decodable {
    let main: Temp
}

struct Temp: Decodable {
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
    func getConditionCity(city: String, callback : @escaping (Condition?) -> Void) {
        guard let request = createWeatherRequest(city: city) else { return }

        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(nil)
                    print("a")
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(nil)
                    print("b")
                    return
                }

                do {
                    let queryCityJson = try JSONDecoder().decode(Condition.self, from: data)
                    print(queryCityJson)
                    callback(queryCityJson)

                } catch {
                    callback(nil)
                }
            }
        }
    task?.resume()
    }

    private func createWeatherRequest(city: String) -> URLRequest? {
        let citySelected = "'\(city)'"

        guard let conditionCity = URL(string: "api.openweathermap.org/data/2.5/weather?q=\(citySelected)&APPID=85137168b0d35695bae170138afe609d&units=metric") else { return nil }

        let request = URLRequest(url: conditionCity)
        return request
    }


}

