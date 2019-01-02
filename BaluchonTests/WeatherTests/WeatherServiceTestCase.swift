//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by AMIMOBILE on 19/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {
    
    func testGetConditionCityShoulNilIfError() {
        
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        weatherService.getConditionCity(city: "") { (conditionCity) in
            
            // Then
            XCTAssertNil(conditionCity)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConditioCityShouldNilIfNoData() {
        
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: nil,
            response: nil,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        weatherService.getConditionCity(city: "") { (conditionCity) in
            
                // Then
                XCTAssertNil(conditionCity)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConditionCityShouldNilIfIncorrectResponse() {
        
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseKO,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        weatherService.getConditionCity(city: "") { (conditionCity) in
            
            // Then
            XCTAssertNil(conditionCity)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConditionCityShouldNilIfIncorrectData() {

        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        weatherService.getConditionCity(city: "") { (conditionCity) in

            // Then
            XCTAssertNil(conditionCity)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetConditionCityShouldSuccessIfCorrectDataAndNoError() {
        
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseOK,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        weatherService.getConditionCity(city: "paris") { (conditionCity) in
            
            // Then
            XCTAssertNotNil(conditionCity)
            let tempParis = "10"
            let condParis = "Cloudy"
            XCTAssertEqual(tempParis, conditionCity?.temp)
            XCTAssertEqual(condParis, conditionCity?.text)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
