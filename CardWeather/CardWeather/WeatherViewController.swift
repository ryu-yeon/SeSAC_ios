//
//  WeatherViewController.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/12.
//

import CoreLocation
import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        WeatherAPIManager.shared.requestWeather(lat: 37.517829, lon: 126.886270) { weather in
            print(weather)
        }
    }
}


