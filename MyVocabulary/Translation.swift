//
//  Translation.swift
//  MyVocabulary
//
//  Created by Nikita Misko on 03.02.17.
//  Copyright © 2017 Nikita Misko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Translation {
    var word = ""
    var translatedWord = ""
    
    init(word: String, translatedWord: String) {
        self.translatedWord = translatedWord
        self.word = word
    }
    
    static func getTranslation(with string: String, comletion: @escaping (Translation) -> ()) {
        let stringURL = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let fullURLstring = String(format: "https://www.googleapis.com/language/translate/v2?q=%@&target=ru&key=AIzaSyCnFOjLynQOxfLibOENhgGB26_qAz-_eSc", stringURL)
        let url = URL(string: fullURLstring)!
        Alamofire.request(url).responseJSON { (response) in
            let json = JSON(data: response.data!)
            var text = ""
            if let translatedText = json["data", "translations", 0, "translatedText"].string {
                print("***Translated text: \(translatedText)")
                text = translatedText
            }
            let translation = Translation(word: string, translatedWord: text)
            comletion(translation)
        }
    }
}
