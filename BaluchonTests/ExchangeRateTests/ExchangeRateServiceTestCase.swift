//
//  ExchangeRateServiceTestCase.swift
//  BaluchonTests
//
//  Created by AMIMOBILE on 17/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import XCTest
@testable import Baluchon

class ExchangeRateServiceTestCase: XCTestCase {
    
    // MARK : - Test getCurrency
    func testGetCurrencyShouldPostFailedCallbackIfError() {
        // Given
        let exchangeRateService = ExchangeRateService(
            currencySession: URLSessionFake(
                data: nil,
                response: nil,
                error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeRateService.getCurrency { (success, symbols) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeRateService = ExchangeRateService(
            currencySession: URLSessionFake(data: nil, response: nil, error: nil))
    
        // When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeRateService.getCurrency { (success, symbols) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeRateService = ExchangeRateService(currencySession: URLSessionFake(
            data: FakeResponseData.currencyCorrectData,
            response: FakeResponseData.responseKO,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeRateService.getCurrency { (success, symbols) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let exchangeRateService = ExchangeRateService(currencySession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil))

        // When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeRateService.getCurrency { (success, symbols) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyShoudPostSuccesIfNoErrorAndCorrectData() {
        // Given
        let exchangeRateService = ExchangeRateService(currencySession: URLSessionFake(
            data: FakeResponseData.currencyCorrectData,
            response: FakeResponseData.responseOK,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "wait for queu change")
        exchangeRateService.getCurrency { (success, symbols) in
            
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(symbols)
            let currency = ["AED": "United Arab Emirates Dirham",
                            "AFN": "Afghan Afghani",
                            "ALL": "Albanian Lek",
                            "AMD": "Armenian Dram",
                            "ANG": "Netherlands Antillean Guilder",
                            "AOA": "Angolan Kwanza",
                            "ARS": "Argentine Peso",
                            "AUD": "Australian Dollar",
                            "AWG": "Aruban Florin",
                            "AZN": "Azerbaijani Manat",
                            "BAM": "Bosnia-Herzegovina Convertible Mark",
                            "BBD": "Barbadian Dollar",
                            "BDT": "Bangladeshi Taka",
                            "BGN": "Bulgarian Lev",
                            "BHD": "Bahraini Dinar",
                            "BIF": "Burundian Franc",
                            "BMD": "Bermudan Dollar",
                            "BND": "Brunei Dollar",
                            "BOB": "Bolivian Boliviano",
                            "BRL": "Brazilian Real",
                            "BSD": "Bahamian Dollar",
                            "BTC": "Bitcoin",
                            "BTN": "Bhutanese Ngultrum",
                            "BWP": "Botswanan Pula",
                            "BYN": "New Belarusian Ruble",
                            "BYR": "Belarusian Ruble",
                            "BZD": "Belize Dollar",
                            "CAD": "Canadian Dollar",
                            "CDF": "Congolese Franc",
                            "CHF": "Swiss Franc",
                            "CLF": "Chilean Unit of Account (UF)",
                            "CLP": "Chilean Peso",
                            "CNY": "Chinese Yuan",
                            "COP": "Colombian Peso",
                            "CRC": "Costa Rican Colón",
                            "CUC": "Cuban Convertible Peso",
                            "CUP": "Cuban Peso",
                            "CVE": "Cape Verdean Escudo",
                            "CZK": "Czech Republic Koruna",
                            "DJF": "Djiboutian Franc",
                            "DKK": "Danish Krone",
                            "DOP": "Dominican Peso",
                            "DZD": "Algerian Dinar",
                            "EGP": "Egyptian Pound",
                            "ERN": "Eritrean Nakfa",
                            "ETB": "Ethiopian Birr",
                            "EUR": "Euro",
                            "FJD": "Fijian Dollar",
                            "FKP": "Falkland Islands Pound",
                            "GBP": "British Pound Sterling",
                            "GEL": "Georgian Lari",
                            "GGP": "Guernsey Pound",
                            "GHS": "Ghanaian Cedi",
                            "GIP": "Gibraltar Pound",
                            "GMD": "Gambian Dalasi",
                            "GNF": "Guinean Franc",
                            "GTQ": "Guatemalan Quetzal",
                            "GYD": "Guyanaese Dollar",
                            "HKD": "Hong Kong Dollar",
                            "HNL": "Honduran Lempira",
                            "HRK": "Croatian Kuna",
                            "HTG": "Haitian Gourde",
                            "HUF": "Hungarian Forint",
                            "IDR": "Indonesian Rupiah",
                            "ILS": "Israeli New Sheqel",
                            "IMP": "Manx pound",
                            "INR": "Indian Rupee",
                            "IQD": "Iraqi Dinar",
                            "IRR": "Iranian Rial",
                            "ISK": "Icelandic Króna",
                            "JEP": "Jersey Pound",
                            "JMD": "Jamaican Dollar",
                            "JOD": "Jordanian Dinar",
                            "JPY": "Japanese Yen",
                            "KES": "Kenyan Shilling",
                            "KGS": "Kyrgystani Som",
                            "KHR": "Cambodian Riel",
                            "KMF": "Comorian Franc",
                            "KPW": "North Korean Won",
                            "KRW": "South Korean Won",
                            "KWD": "Kuwaiti Dinar",
                            "KYD": "Cayman Islands Dollar",
                            "KZT": "Kazakhstani Tenge",
                            "LAK": "Laotian Kip",
                            "LBP": "Lebanese Pound",
                            "LKR": "Sri Lankan Rupee",
                            "LRD": "Liberian Dollar",
                            "LSL": "Lesotho Loti",
                            "LTL": "Lithuanian Litas",
                            "LVL": "Latvian Lats",
                            "LYD": "Libyan Dinar",
                            "MAD": "Moroccan Dirham",
                            "MDL": "Moldovan Leu",
                            "MGA": "Malagasy Ariary",
                            "MKD": "Macedonian Denar",
                            "MMK": "Myanma Kyat",
                            "MNT": "Mongolian Tugrik",
                            "MOP": "Macanese Pataca",
                            "MRO": "Mauritanian Ouguiya",
                            "MUR": "Mauritian Rupee",
                            "MVR": "Maldivian Rufiyaa",
                            "MWK": "Malawian Kwacha",
                            "MXN": "Mexican Peso",
                            "MYR": "Malaysian Ringgit",
                            "MZN": "Mozambican Metical",
                            "NAD": "Namibian Dollar",
                            "NGN": "Nigerian Naira",
                            "NIO": "Nicaraguan Córdoba",
                            "NOK": "Norwegian Krone",
                            "NPR": "Nepalese Rupee",
                            "NZD": "New Zealand Dollar",
                            "OMR": "Omani Rial",
                            "PAB": "Panamanian Balboa",
                            "PEN": "Peruvian Nuevo Sol",
                            "PGK": "Papua New Guinean Kina",
                            "PHP": "Philippine Peso",
                            "PKR": "Pakistani Rupee",
                            "PLN": "Polish Zloty",
                            "PYG": "Paraguayan Guarani",
                            "QAR": "Qatari Rial",
                            "RON": "Romanian Leu",
                            "RSD": "Serbian Dinar",
                            "RUB": "Russian Ruble",
                            "RWF": "Rwandan Franc",
                            "SAR": "Saudi Riyal",
                            "SBD": "Solomon Islands Dollar",
                            "SCR": "Seychellois Rupee",
                            "SDG": "Sudanese Pound",
                            "SEK": "Swedish Krona",
                            "SGD": "Singapore Dollar",
                            "SHP": "Saint Helena Pound",
                            "SLL": "Sierra Leonean Leone",
                            "SOS": "Somali Shilling",
                            "SRD": "Surinamese Dollar",
                            "STD": "São Tomé and Príncipe Dobra",
                            "SVC": "Salvadoran Colón",
                            "SYP": "Syrian Pound",
                            "SZL": "Swazi Lilangeni",
                            "THB": "Thai Baht",
                            "TJS": "Tajikistani Somoni",
                            "TMT": "Turkmenistani Manat",
                            "TND": "Tunisian Dinar",
                            "TOP": "Tongan Paʻanga",
                            "TRY": "Turkish Lira",
                            "TTD": "Trinidad and Tobago Dollar",
                            "TWD": "New Taiwan Dollar",
                            "TZS": "Tanzanian Shilling",
                            "UAH": "Ukrainian Hryvnia",
                            "UGX": "Ugandan Shilling",
                            "USD": "United States Dollar",
                            "UYU": "Uruguayan Peso",
                            "UZS": "Uzbekistan Som",
                            "VEF": "Venezuelan Bolívar Fuerte",
                            "VND": "Vietnamese Dong",
                            "VUV": "Vanuatu Vatu",
                            "WST": "Samoan Tala",
                            "XAF": "CFA Franc BEAC",
                            "XAG": "Silver (troy ounce)",
                            "XAU": "Gold (troy ounce)",
                            "XCD": "East Caribbean Dollar",
                            "XDR": "Special Drawing Rights",
                            "XOF": "CFA Franc BCEAO",
                            "XPF": "CFP Franc",
                            "YER": "Yemeni Rial",
                            "ZAR": "South African Rand",
                            "ZMK": "Zambian Kwacha (pre-2013)",
                            "ZMW": "Zambian Kwacha",
                            "ZWL": "Zimbabwean Dollar"]
            let symbolsCurrency = currency.map({$0.key})
            XCTAssertEqual(symbolsCurrency.sorted{$0 < $1}, symbols!.sorted{$0 < $1})
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK : - Test getRate
    func testGetRateShouldPostFailedCallbackIfError() {
        // Given
        let exchangeRateService = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        exchangeRateService.getRate(symbol: "") { (success, rate) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRateShouldPostFaileCallbackIfNoData() {
        // Given
        let exchangeRateService = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        exchangeRateService.getRate(symbol: "") { (success, rate) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeRateService = ExchangeRateService(rateSession: URLSessionFake(
            data: FakeResponseData.rateCorrectData,
            response: FakeResponseData.responseKO,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        exchangeRateService.getRate(symbol: "") { (success, rate) in
            
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
        func testGetRateShouldPostFailedCallbackIfIncorrectData() {
            // Given
            let exchangeRateService = ExchangeRateService(rateSession: URLSessionFake(
                data: FakeResponseData.incorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
    
            // When
            let expectation = XCTestExpectation(description: "wait for queu change")
            exchangeRateService.getRate(symbol: "") { (success, rate) in
    
                // Then
                XCTAssertFalse(success)
                XCTAssertNil(rate)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetRateShouldPostSuccessIfNoErrorAndCorrectData() {
        // Given
        let exchangeRateSerivce = ExchangeRateService(rateSession: URLSessionFake(
            data: FakeResponseData.rateCorrectData,
            response: FakeResponseData.responseOK,
            error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queu change")
        exchangeRateSerivce.getRate(symbol: "USD") { (success, rate) in
            
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(rate)
            let rates = [
                "AED": 4.176262,
                "AFN": 86.126804,
                "ALL": 123.078592,
                "AMD": 551.119139,
                "ANG": 2.018256,
                "AOA": 350.59763,
                "ARS": 43.501311,
                "AUD": 1.585071,
                "AWG": 2.046572,
                "AZN": 1.935718,
                "BAM": 1.951804,
                "BBD": 2.276015,
                "BDT": 95.388433,
                "BGN": 1.956637,
                "BHD": 0.428654,
                "BIF": 2073.290807,
                "BMD": 1.136984,
                "BND": 1.791842,
                "BOB": 7.857073,
                "BRL": 4.436523,
                "BSD": 1.137155,
                "BTC": 0.000322,
                "BTN": 80.107158,
                "BWP": 12.168055,
                "BYN": 2.418026,
                "BYR": 22284.891596,
                "BZD": 2.291932,
                "CAD": 1.532848,
                "CDF": 1846.462792,
                "CHF": 1.128461,
                "CLF": 0.028479,
                "CLP": 783.952112,
                "CNY": 7.839619,
                "COP": 3635.166092,
                "CRC": 678.535185,
                "CUC": 1.136984,
                "CUP": 30.130083,
                "CVE": 110.994111,
                "CZK": 25.723139,
                "DJF": 202.064734,
                "DKK": 7.467621,
                "DOP": 57.252815,
                "DZD": 134.973366,
                "EGP": 20.36224,
                "ERN": 17.055268,
                "ETB": 31.573948,
                "EUR": 1,
                "FJD": 2.40944,
                "FKP": 0.886837,
                "GBP": 0.898854,
                "GEL": 303.005738,
                "GGP": 0.898981,
                "GHS": 5.560422,
                "GIP": 0.886836,
                "GMD": 56.297797,
                "GNF": 10454.570585,
                "GTQ": 8.800884,
                "GYD": 237.789269,
                "HKD": 8.890592,
                "HNL": 27.696876,
                "HRK": 7.413367,
                "HTG": 87.410785,
                "HUF": 322.305469,
                "IDR": 16419.246622,
                "ILS": 4.274914,
                "IMP": 0.898981,
                "INR": 80.054699,
                "IQD": 1354.14826,
                "IRR": 47872.722333,
                "ISK": 139.064471,
                "JEP": 0.898981,
                "JMD": 145.943331,
                "JOD": 0.80692,
                "JPY": 127.966464,
                "KES": 116.430815,
                "KGS": 79.397548,
                "KHR": 4571.813564,
                "KMF": 492.532506,
                "KPW": 1023.352114,
                "KRW": 1282.415807,
                "KWD": 0.345875,
                "KYD": 0.947574,
                "KZT": 421.844058,
                "LAK": 9721.21564,
                "LBP": 1712.468917,
                "LKR": 204.724976,
                "LRD": 178.506932,
                "LSL": 16.247686,
                "LTL": 3.357219,
                "LVL": 0.68775,
                "LYD": 1.597439,
                "MAD": 10.885833,
                "MDL": 19.711327,
                "MGA": 4024.923909,
                "MKD": 61.52165,
                "MMK": 1797.797848,
                "MNT": 2997.991404,
                "MOP": 9.159602,
                "MRO": 405.903484,
                "MUR": 39.17536,
                "MVR": 17.566324,
                "MWK": 845.217098,
                "MXN": 22.869078,
                "MYR": 4.769082,
                "MZN": 70.009809,
                "NAD": 16.314632,
                "NGN": 414.999216,
                "NIO": 36.815885,
                "NOK": 9.904691,
                "NPR": 128.17217,
                "NZD": 1.659707,
                "OMR": 0.437785,
                "PAB": 1.137041,
                "PEN": 3.798266,
                "PGK": 3.820254,
                "PHP": 60.168874,
                "PKR": 158.270188,
                "PLN": 4.284316,
                "PYG": 6727.365343,
                "QAR": 4.13973,
                "RON": 4.646168,
                "RSD": 118.279811,
                "RUB": 76.360198,
                "RWF": 994.861232,
                "SAR": 4.264944,
                "SBD": 9.246013,
                "SCR": 15.510173,
                "SDG": 54.146594,
                "SEK": 10.303931,
                "SGD": 1.559151,
                "SHP": 1.50184,
                "SLL": 9721.215164,
                "SOS": 660.587597,
                "SRD": 8.479656,
                "STD": 23934.200527,
                "SVC": 9.949692,
                "SYP": 585.547177,
                "SZL": 16.247795,
                "THB": 37.225466,
                "TJS": 10.717447,
                "TMT": 3.990815,
                "TND": 3.342508,
                "TOP": 2.568675,
                "TRY": 6.082182,
                "TTD": 7.664013,
                "TWD": 35.036195,
                "TZS": 2615.292745,
                "UAH": 31.723012,
                "UGX": 4207.136104,
                "USD": 1.136984,
                "UYU": 36.747614,
                "UZS": 9476.763201,
                "VEF": 282617.62066,
                "VND": 26515.041554,
                "VUV": 128.898418,
                "WST": 2.959599,
                "XAF": 654.596313,
                "XAG": 0.077597,
                "XAU": 0.00091,
                "XCD": 3.072757,
                "XDR": 0.82153,
                "XOF": 662.862125,
                "XPF": 119.781432,
                "YER": 284.653934,
                "ZAR": 16.291054,
                "ZMK": 10234.215074,
                "ZMW": 13.616482,
                "ZWL": 366.512575
            ]
            XCTAssertEqual(rates["USD"], rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
