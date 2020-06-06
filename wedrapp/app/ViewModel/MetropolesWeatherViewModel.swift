//
//  MetropolesWeatherViewModel.swift
//  weatherAppJunior
//
//  Created by ljanosova on 30.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import Foundation

final class MetropolesWeatherViewModel {
    
    private let metropoles = ["London","Barcelona","Berlin","Paris","Prague","Rome","Lisbon"]
    private var metropoleNames: [String] = []
    private(set) var metropolesWeather: [CurrentWeather]?
    
    func loadAllMetropoles() {
        if metropolesWeather != nil {
            return
        }
        metropolesWeather = []
        for metropole in metropoles {
            RequestManager.loadCurrentWeather("q=\(metropole)") { [weak self] (response, errorCode) in
                if let weather = response, let name = weather.cityName {
                    self?.metropolesWeather?.append(weather)
                    self?.metropoleNames.append(name)
                }
            }
        }
    }
    
    func metropoleName(index: Int) -> String {
        return metropoleNames[index]
    }
    
}
