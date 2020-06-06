//
//  RequestManager.swift
//  weatherAppJunior
//
//  Created by ljanosova on 7.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//
import Foundation
import Alamofire
import AlamofireObjectMapper

enum ResponseResult {
    case notFoundError
    case unknownError
    case success
}

final class RequestManager {
    
    static func loadForecast(_ paramValue: String, completion: @escaping (_ result: ForecastArray?, _ statusCode: Int?) -> Void) -> Void {
        guard let url = Endpoint(paramName: .forecast, paramValue: paramValue).getUrl() else {
            completion(nil, 400)
            return
        }
        
        Alamofire.request(url).responseObject { (response: DataResponse<ForecastArray>) in
            guard let data = response.value else {
                completion(nil, 400)
                return
            }
            if data.forecast != nil {
                completion(data, nil)
            } else {
                completion(nil, 400)
            }
        }
    }
    
    static func loadCurrentWeather(_ paramValue: String, completion: @escaping (_ result: CurrentWeather?, _ statusCode: Int?) -> Void) -> Void {
        guard let url = Endpoint(paramName: .weather, paramValue: paramValue).getUrl() else {
            completion(nil, 400)
            return
        }
        
        Alamofire.request(url).responseObject { (response: DataResponse<CurrentWeather>) in
            guard let data = response.value else {
                completion(nil, response.response?.statusCode)
                return
            }
            if let code = data.cod {
                if code < 300 && code >= 200 {
                    completion(data, nil)
                } else {
                    completion(nil, code)
                }
            } else {
                completion(nil, 400)
            }
        }
    }
}
