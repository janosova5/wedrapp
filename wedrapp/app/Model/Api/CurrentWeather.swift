//
//  CurrentWeather.swift
//  weatherAppJunior
//
//  Created by ljanosova on 7.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

//api.openweathermap.org/data/2.5/weather?q={city name}

import ObjectMapper

class WeatherObject: NSObject, Mappable {
    
    var title: String?
    var desc: String?
    var icon: String?
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        icon <- map["icon"]
        title <- map["main"]
        desc <- map["description"]
    }
    
}

class CurrentWeather: NSObject, Mappable {
    var weather: [WeatherObject]?
    var minTemp: Double?
    var maxTemp: Double?
    var temp: Double?
    var pressure: Double?
    var humidity: Double?
    var windSpeed: Double?
    var cityName: String?
    var cod: Int?
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        weather <- map["weather"]
        minTemp <- map["main.temp_min"]
        maxTemp <- map["main.temp_max"]
        temp <- map["main.temp"]
        pressure <- map["main.pressure"]
        humidity <- map["main.humidity"]
        windSpeed <- map["wind.speed"]
        cityName <- map["name"]
        cod <- map["cod"]
    }
    
}
