//
//  TranslateServiceTestCase.swift
//  BaluchonTests
//
//  Created by AMIMOBILE on 19/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import XCTest
@testable import Baluchon

class TranslateServiceTestCase: XCTestCase {
    
    
    func testGetTranslatedTextShouldPostFailedIfError() {
        
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        translateService.getTranslatedText(text: "") { (success, translatedText) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslatedTextShouldPostFailedIfNoData() {
        
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: nil,
            response: nil,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        translateService.getTranslatedText(text: "") { (success, translatedText) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslatedTextShouldPostFailedIfIncorrectResponse() {
        
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseKO,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        translateService.getTranslatedText(text: "") { (success, translatedText) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslatedTextShouldPostFailedIfIncorrectData() {
        
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        translateService.getTranslatedText(text: "") { (success, translatedText) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslatedTextShouldPostSuccessIfCorrectDataAndNoError() {
        
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseOK,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        translateService.getTranslatedText(text: "Bonjour, j'aime travailler dans l'informatique") { (success, translatedText) in
            
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            let resultText = "Hello, I like working in IT"
            XCTAssertEqual(resultText, translatedText!)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
}
