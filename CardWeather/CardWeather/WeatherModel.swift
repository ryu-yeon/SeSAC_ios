//
//  WeatherModel.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/12.
//

import Foundation

//struct Weather {
//    let temp: Double
//    let temp_Max: Double
//    let temp_Min: Double
//    let description: String
//    let id: Int
//    let main: String
//    let location: String
//    let wind: Double
//    let humidity: Int
//    let icon: String
//}

struct WeatherData: Codable{
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
}

struct Main: Codable {
    let temp_max: Double
    let temp_min: Double
    let temp: Double
    let humidity: Int
    
}

struct Wind: Codable {
    let speed: Double
}
