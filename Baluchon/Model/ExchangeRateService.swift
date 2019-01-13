//
//  Currency.swift
//  Baluchon
//
//  Created by AMIMOBILE on 23/11/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import Foundation

// MARK : - Struct JSON
struct Currency: Decodable {
    let symbols: [String: String]
}

struct Rates: Decodable {
    let rates: [String: Double]
}

class ExchangeRateService {

    // MARK : - Vars
    private var task: URLSessionDataTask?
    private var currencySession: URLSession
    private var rateSession: URLSession
    init(currencySession: URLSession = URLSession(configuration: .default), rateSession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
        self.rateSession = rateSession
    }
    
    // MARK : - Functions request
    func getCurrency(callback : @escaping (Bool, [String]?)-> Void) {

        task?.cancel()
        guard let currencyUrl = URL(string: "http://data.fixer.io/api/symbols?access_key=a232dffeb7aac4d2143830620eb8b4c7") else { return }
        task = currencySession.dataTask(with: currencyUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                do {
                    let currencyJSON = try JSONDecoder().decode(Currency.self, from: data)
                    let symbolsJSON = currencyJSON.symbols.map({$0.key})
                    callback(true, symbolsJSON)
                    } catch let jsonError {
                        callback(false, nil)
                        print("Error Load Currency", jsonError)
                }
            }
        }
        task?.resume()
    }
    
    func getRate(symbol: String, callback: @escaping (Bool, Double?) -> Void) {

        task?.cancel()
        guard let rateUrl = URL(string: "http://data.fixer.io/api/latest?access_key=a232dffeb7aac4d2143830620eb8b4c7") else { return }
        task = rateSession.dataTask(with: rateUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                do {
                    let rateJSON = try JSONDecoder().decode(Rates.self, from: data)
                    let rate = rateJSON.rates[symbol]
                    callback(true, rate)
                } catch let jsonError {
                    callback(false, nil)
                    print("Error load Rate List", jsonError)
                }
            }
        }
        task?.resume()
    }
}

