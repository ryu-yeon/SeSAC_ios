//
//  WeatherViewController.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/12.
//

import CoreLocation
import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    let format = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        
        format.dateFormat = "M. d(EEEEE) h:mm a"
        let date = format.string(from: Date())
        dateLabel.text = date
        dateLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        dateLabel.textColor = .white
        
        locationLabel.font = .systemFont(ofSize: 36, weight: .bold)
        locationLabel.textColor = .white
        
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .white
        
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        
        settingButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
        settingButton.tintColor = .white
        
        
        WeatherAPIManager.shared.requestWeather(lat: 37.517829, lon: 126.886270) { weather in
            print(weather)
            
            self.locationLabel.text = weather.name
        }
    }
}


