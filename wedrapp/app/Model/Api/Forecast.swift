//
//  Forecast.swift
//  weatherAppJunior
//
//  Created by ljanosova on 7.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

//api.openweathermap.org/data/2.5/forecast?q={city name},{country code}

import ObjectMapper

class Forecast: NSObject, Mappable {
    
    var temp: Double?
    var day: String?
    var weather: [WeatherObject]? // icon
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        temp <- map["main.temp"]
        day <- map["dt_txt"]
        weather <- map["weather"]
    }
    
}

class ForecastArray: NSObject, Mappable {
    
    var forecast: [Forecast]?
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        forecast <- map["list"]
    }
    
}
