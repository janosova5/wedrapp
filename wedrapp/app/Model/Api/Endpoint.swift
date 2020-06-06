//
//  Endpoint.swift
//  weatherAppJunior
//
//  Created by ljanosova on 7.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import Foundation

enum ParamName: String {
    case weather = "weather"
    case forecast = "forecast"
}


final class Endpoint {
    
    private let base: String = "https://api.openweathermap.org/data/"
    private let apiVersion: String = "2.5"
    private let appId: String = "&APPID=5acf45972b19acdfc98f8b5b055518e8"
    private let url: URL?
    
    init(paramName: ParamName, paramValue: String) {
        let stringUrl = base + apiVersion + "/" + paramName.rawValue + "?" + paramValue + appId
        url = URL(string: stringUrl)
    }
    
    func getUrl() -> URL? {
        return url
    }
}
