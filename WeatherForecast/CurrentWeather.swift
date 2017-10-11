//
//  CurrentWeather.swift
//  weatherforecast
//
//  Created by Muhammad Noor on 11/10/2017.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    let temperature: Double?
    let summary: String?
    
    struct WeatherKey {
        static let temperature = "temperature"
        static let summary = "summary"
    }
    
    init(weatherDictionary: [String: Any]) {
        temperature = weatherDictionary[WeatherKey.temperature] as? Double
        summary = weatherDictionary[WeatherKey.summary] as? String
    }
    
    
}




