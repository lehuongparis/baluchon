//
//  WeatherService.swift
//  Baluchon
//
//  Created by AMIMOBILE on 07/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import Foundation


struct Weather: Decodable {
    let query: Query
}

struct Query: Decodable {
    let results: Result
}

struct Result: Decodable {
    let channel: Channel
}

struct Channel: Decodable {
    let item: Items
}

struct Items: Decodable {
    let condition: Conditions
}

struct Conditions: Decodable {
    let temp: String
    let text: String
}

class WeatherService {

    private var task: URLSessionDataTask?
    private var weatherSession: URLSession
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
        }
    
    func getConditionCity(city: String, callback : @escaping (Conditions?) -> Void) {

        let citySelected = "'\(city)'"

        let textCityUrl = "select item.condition from weather.forecast where woeid in (select woeid from geo.places(1) where text=\(citySelected)) and u='c'"
        
        guard let encodedTextCityUrl = textCityUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }

        let conditionCity = URL(string: "https://query.yahooapis.com/v1/public/yql?q=\(encodedTextCityUrl)&format=json")!

//        task?.cancel()
        task = weatherSession.dataTask(with: conditionCity) { (data, response, error) in
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
                    let queryCityJson = try JSONDecoder().decode(Weather.self, from: data)
                    let tempCityCondition = queryCityJson.query.results.channel.item.condition
                    callback(tempCityCondition)

                } catch {
                    callback(nil)
                    print("Sorry, We don't have the weather of your city")
                }
            }
        }
    task?.resume()
    }
    
}



