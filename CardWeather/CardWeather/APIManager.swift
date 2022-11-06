//
//  APIManager.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/12.
//

import UIKit

import Alamofire
//import SwiftyJSON

class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
//    typealias completionHandler = (Weather) -> Void
    
    private init() {}
    
//    func requestWeather(lat: Double, lon: Double, completionHandler: @escaping completionHandler) {
//        let url = EndPoint.openweatherURL + "&appid=\(APIKey.openweather)" + "&lat=\(lat)&lon=\(lon)"
//        AF.request(url, method: .get).validate().responseData { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
////                print("JSON: \(json)")
//
//                let id = json["weather"][0]["id"].intValue
//                let main = json["weather"][0]["main"].stringValue
//                let description = json["weather"][0]["description"].stringValue
//                let temp = json["main"]["temp"].doubleValue
//                let temp_Max = json["main"]["temp_max"].doubleValue
//                let temp_Min = json["main"]["temp_min"].doubleValue
//                let location = json["name"].stringValue
//                let wind = json["wind"]["speed"].doubleValue
//                let humidity = json["main"]["humidity"].intValue
//                let icon = json["weather"][0]["icon"].stringValue
//
//                let weatherData = Weather(temp: temp, temp_Max: temp_Max, temp_Min: temp_Min, description: description, id: id, main: main, location: location, wind: wind, humidity: humidity, icon: icon)
//
//                completionHandler(weatherData)
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func requestWeather(lat: Double, lon: Double, completionHandler: @escaping (WeatherData?, Error?) -> Void) {

        let url = EndPoint.openweatherURL + "&appid=\(APIKey.openweather)" + "&lat=\(lat)&lon=\(lon)"
        AF.request(url, method: .get).responseDecodable(of: WeatherData.self) { response in

            switch response.result {
            case .success(let data):
                print(data)
                completionHandler(data, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
}
