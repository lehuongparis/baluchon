//
//  TranslateService.swift
//  Baluchon
//
//  Created by AMIMOBILE on 05/12/2018.
//  Copyright © 2018 lehuong. All rights reserved.
//

import Foundation

// MARK : - Struct JSON
struct Translation: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [TranslationText]
}

struct TranslationText: Decodable {
    let translatedText: String
}

class TranslateService {
    
    // MARK : - Vars
    private var task: URLSessionDataTask?
    private var translateSession: URLSession
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    // MARK : - Functions
    func getTranslatedText(text: String, callback: @escaping (Bool, String?) -> Void) {
        let request = createTranslateResquet(text: text)
        
        task?.cancel()
        task = translateSession.dataTask(with: request) { (data, response, error) in
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
                    let translationJSON = try JSONDecoder().decode(Translation.self, from: data)
                    let translationData = translationJSON.data
                    let translationText = translationData.translations[0]
                    let translatedText = translationText.translatedText
                    callback(true, translatedText)
                } catch {
                    callback(false, nil)
                    print("error")
                }                
            }
        }
        task?.resume()
    }
    
    private func createTranslateResquet(text: String) -> URLRequest {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyD_wDwmFHOY-6MQ09xn2ESjiUTSTjX7g7Y&q=\(encodedText!)&source=fr&target=en&format=text")!
        
        var request = URLRequest(url: translateUrl)
        request.httpMethod = "POST"
        request.httpBody = encodedText!.data(using: String.Encoding.utf8)
        return request
    }
}
