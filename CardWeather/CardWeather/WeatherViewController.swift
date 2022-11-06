//
//  WeatherViewController.swift
//  CardWeather
//
//  Created by 유연탁 on 2022/08/12.
//

import CoreLocation
import UIKit

import Kingfisher

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
    
    var weather: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManger.delegate = self
        
        navigationItem.backButtonTitle = " "
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
        
        temperatureLabel.backgroundColor = .white
        humidityLabel.backgroundColor = .white
        weatherImageView.tintColor = .black
        windLabel.backgroundColor = .white
        greetingLabel.backgroundColor = .white
        
        for view in chatView {
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
        }
        
        updateUI()
    }
    
    func updateUI() {
        locationLabel.text = weather?.name
        temperatureLabel.text = "  지금은 \(weather?.main.temp ?? 0)°C에요.  "
        humidityLabel.text = "  \(weather?.main.humidity ?? 0)%만큼 습해요.  "
        windLabel.text = "  \(weather?.wind.speed ?? 0)m/s의 바람이 불어요.  "
        
        let url = URL(string: EndPoint.iconBaseURL + (weather?.weather[0].icon ?? "") + "@2x.png")
        weatherImageView.kf.setImage(with: url)
    
        greetingLabel.text = setGreeting(id: weather?.weather[0].id ?? 0)
    }
    
    func setGreeting(id: Int) -> String {
        switch id {
        case 200...232:
            return "  천둥번개 조심하세요!!!  "
        case 300...321:
            return "  우산 꼭 챙기세요!  "
        case 500...504:
            return "  비가 와요  "
        case 511:
            return "  진눈깨비?  "
        case 520...531:
            return "  비가 엄청 많이 와요ㅠㅠ  "
        case 600...622:
            return "  눈 오는 중  "
        case 700...781:
            return "  안개  "
        case 800:
            return "  맑은 날씨  "
        case 801...804:
            return "  구름이 조금 있어요.  "
        default:
            return "  좋은하루 되세요^^  "
        }
    }
    
    @IBAction func settingButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SettingViewController.reusableidentifier) as! SettingViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
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
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                //권한요청
                self.checkUserCurrentLocationAuthorization(authorizationStatus)
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 못합니다.")
            }
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
//            WeatherAPIManager.shared.requestWeather(lat: coordinate.latitude, lon: coordinate.longitude) { weather in
//                self.weather = weather
//                self.updateUI()
//            }
            
            WeatherAPIManager.shared.requestWeather(lat: coordinate.latitude, lon: coordinate.longitude) { weather, error in

                guard let weather = weather else {
                    print(error)
                    return
                }

                guard let error = error else {
                    self.weather = weather
                    self.updateUI()
                    return
                }
            }
        }
        locationManger.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLoctionServiceAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
