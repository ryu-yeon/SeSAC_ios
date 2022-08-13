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
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet var chatView: [UIView]!
    
    let format = DateFormatter()
    let locationManger = CLLocationManager()
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManger.delegate = self
        
        view.backgroundColor = .systemMint
        
        format.dateFormat = "M. d(EEEEE) h:mm a"
        let date = format.string(from: Date())
        dateLabel.text = date
        dateLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        dateLabel.textColor = .white
        
        locationLabel.font = .systemFont(ofSize: 56, weight: .bold)
        locationLabel.textColor = .white
        
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .white
        
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .white
        
        settingButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
        settingButton.tintColor = .white
        
        updateUI()
        
    }
    
    func updateUI() {
        locationLabel.text = weather?.name
        
        temperatureLabel.text = "  지금은 \(weather?.temp ?? 0)°C에요.  "
        temperatureLabel.backgroundColor = .white
        
        humidityLabel.text = "  \(weather?.humidity ?? 0)%만큼 습해요.  "
        humidityLabel.backgroundColor = .white
        
        windLabel.text = "  \(weather?.wind ?? 0)m/s의 바람이 불어요.  "
        windLabel.backgroundColor = .white
        
        weatherImageView.image = UIImage(systemName: "cloud.rain")
        weatherImageView.tintColor = .black
        
        greetingLabel.text = "  좋은하루 되세요^^  "
        greetingLabel.backgroundColor = .white
        
        for view in chatView {
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
        }
        
    }
    
}

extension WeatherViewController {
    
    func checkUserDeviceLoctionServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            //인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManger.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            //권한요청
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
        }
        
        
        
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
       
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINE")
            
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정 유도")
        case .authorizedWhenInUse:
            print("WHEN IN US")
            
            locationManger.startUpdatingLocation()
        default: print("DEFAULT")
        }
        
    }
    
}


extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        
        locationManger.startUpdatingLocation()
        
        if let coordinate = locations.last?.coordinate {
            WeatherAPIManager.shared.requestWeather(lat: coordinate.latitude, lon: coordinate.longitude) { weather in
                self.weather = weather
                self.updateUI()
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLoctionServiceAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
