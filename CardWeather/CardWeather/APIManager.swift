//
//  APIManager.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    typealias completionHandler = (Weather) -> Void
    
    private init() {}
    
    func requestWeather(lat: Double, lon: Double, completionHandler: @escaping completionHandler) {
        let url = EndPoint.openweatherURL + "&appid=\(APIKey.openweather)" + "&lat=\(lat)&lon=\(lon)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                let id = json["weather"]["id"].intValue
                let main = json["weather"]["main"].stringValue
                let description = json["weather"]["description"].stringValue
                let temp = json["main"]["temp"].doubleValue
                let temp_Max = json["main"]["temp_max"].doubleValue
                let temp_Min = json["main"]["temp_min"].doubleValue
                
                let weatherData = Weather(temp: temp, temp_Max: temp_Max, temp_Min: temp_Min, description: description, id: id, main: main)
                
                completionHandler(weatherData)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
