//
//  MapViewController.swift
//  TMDB
//
//  Created by 유연탁 on 2022/08/11.
//

import CoreLocation
import UIKit
import MapKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let theaterList = TheaterList()
    
    let locationManager = CLLocationManager()
    var center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        navigationItem.title = "영화관 찾기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTheater))
        
        setRegionAndAnnotation(center: center, title: "청년취업사관학교 영등포캠퍼스")
    }

    func setRegionAndAnnotation(center: CLLocationCoordinate2D, title: String) {

        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
    
        annotation.coordinate = center
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    @objc func filterTheater() {
        
        mapView.removeAnnotations(mapView.annotations)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megabox = UIAlertAction(title: "메가박스", style: .default) { alert in
            self.showTheater(type: "메가박스")
        }
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { alert in
            self.showTheater(type: "롯데시네마")
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { alert in
            self.showTheater(type: "CGV")
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { alert in
            self.showTheater(type: "롯데시네마")
            self.showTheater(type: "메가박스")
            self.showTheater(type: "CGV")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(megabox)
        alert.addAction(lotteCinema)
        alert.addAction(cgv)
        alert.addAction(all)
        alert.addAction(cancel)

        present(alert, animated: true)

    }
    
    func showTheater(type: String) {

        for i in 0..<theaterList.mapAnnotations.count {
            if theaterList.mapAnnotations[i].type == type {
                let theaterLocation = CLLocationCoordinate2D(latitude: theaterList.mapAnnotations[i].latitude, longitude: theaterList.mapAnnotations[i].longitude)
                setRegionAndAnnotation(center: theaterLocation, title: theaterList.mapAnnotations[i].location)
            }
        }
    }
    
    @IBAction func locationButtonClicked(_ sender: UIButton) {
        checkUserDeviceLocationServiceAutorization()
    }
    
    
}

extension MapViewController {
    
    func checkUserDeviceLocationServiceAutorization() {
        
        let autorizationSatuts: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            autorizationSatuts = locationManager.authorizationStatus
        } else {
            autorizationSatuts = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(autorizationSatuts)
        } else {
            print("위치 서비스가 꺼져 있어 위치 권한 요청을 못함.")
        }
        
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus)
    {
        switch authorizationStatus {
        case .notDetermined:
            print("NOTDETERMINED")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
        default: print("DEFAULT")
        }
    }
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
        
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}



extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate, title: "현재위치")
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAutorization()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
}
