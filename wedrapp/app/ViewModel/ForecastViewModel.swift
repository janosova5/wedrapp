//
//  ForecastViewModel.swift
//  weatherAppJunior
//
//  Created by ljanosova on 10.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

final class ForecastViewModel {
    
    private(set) var forecast: ForecastArray?
    private(set) var countOfFirstSectionRows = 8
    
    var locationViewModel: LocationViewModel?
    
    func getForecastFor(index: Int) -> Forecast? {
        guard let forecastArray = forecast else {
            return nil
        }
        guard let forecast = forecastArray.forecast else {
            return nil
        }
        if index < forecast.count {
            return forecast[index]
        }
        return nil
    }
    
    func setForecast(_ paramValue: String, completion: @escaping (ResponseResult) -> Void) {
        RequestManager.loadForecast(paramValue) { [weak self] (response, errorCode) in
            if let forecastArray = response {
                self?.forecast = forecastArray
                self?.divideForecastArray()
                completion(.success)
            } else {
                completion(.unknownError)
            }
        }
    }
    
    func getForecastDay(at index: Int) -> String {
        // 2014-07-23 09:00:00
        if let timestamp = getForecastFor(index: index)?.day {
            let endIndex = timestamp.index(timestamp.endIndex, offsetBy: -9)
            return String(timestamp[...endIndex])
        }
        return ""
    }
    
    func getForecastHours(at index: Int) -> String {
        if let timestamp = getForecastFor(index: index)?.day {
            let startIndex = timestamp.index(timestamp.startIndex, offsetBy: 11)
            let endIndex = timestamp.index(timestamp.endIndex, offsetBy: -3)
            return String(timestamp[startIndex..<endIndex])
        }
        return ""
    }
    
    func forecastCount() -> Int {
        return forecast?.forecast?.count ?? 0
    }
    
    private func divideForecastArray() {
        let day = getForecastDay(at: 0)
        var index = 0
        var count = 0
        while day == getForecastDay(at: index) {
            index = index + 1
            count = count + 1
        }
        countOfFirstSectionRows = count
    }
    
}
