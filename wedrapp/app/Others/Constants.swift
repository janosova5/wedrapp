//
//  Constants.swift
//  weatherAppJunior
//
//  Created by ljanosova on 14.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

final class C {
    
    public enum CGFloats: CGFloat {
        case recentSearchesCellHeight = 40
        case forecastCell = 50
        case forecastHeader = 60
        case metropoleCell = 110
    }
    
    public enum Numbers: Int {
        case rowsMaxCount = 8
    }
    
    public enum Strings: String {
        case error = "Something went wrong"
        case error404 = "Location not found"
        case errorTitle = "Request failed"
        case recentSearchesCell = "recentSearchesCell"
        case recentSearches = "Recent searches"
        case recentSearchesKey = "recentSearches"
        case recentSearchesSegue = "recentSearchesSegue"
        case forecastCell = "forecastCell"
        case forecastController = "ForecastControllerId"
        case currentWeatherController = "CurrentWeatherControllerId"
        case cell = "cell"
        case selectionCell = "selectionCell"
    }
    
}

