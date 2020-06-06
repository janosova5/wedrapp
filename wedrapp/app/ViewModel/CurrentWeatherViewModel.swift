//
//  CurrentWeatherViewModel.swift
//  weatherAppJunior
//
//  Created by ljanosova on 10.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

final class CurrentWeatherViewModel {
    
    private(set) var currentWeather: CurrentWeather?
    var locationViewModel: LocationViewModel?
    
    func setCurrentWeather(_ paramValue: String, completion: @escaping (ResponseResult) -> Void) {
        RequestManager.loadCurrentWeather(paramValue) { [weak self] (response, errorCode) in
            if let weather = response {
                self?.currentWeather = weather
                let userLocationName = self?.currentWeather?.cityName?.replacingOccurrences(of: " ", with: "+")
                self?.locationViewModel?.userLocationName.value = userLocationName
                completion(.success)
            } else if errorCode == 404 {
                completion(.notFoundError)
            } else {
                completion(.unknownError)
            }
        }
    }
    
    func weatherObject() -> WeatherObject? {
        return currentWeather?.weather?.last
    }
    
}
