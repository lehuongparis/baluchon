//
//  FakeExchangeRateResponseData.swift
//  BaluchonTests
//
//  Created by AMIMOBILE on 17/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Data
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var rateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Rate", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static let incorrectData = "Error".data(using: .utf8)!
    static let incorrectRateData = "13.342".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class ServiceError: Error {}
    static let error = ServiceError()
}






