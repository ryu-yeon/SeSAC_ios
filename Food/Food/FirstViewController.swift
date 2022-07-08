//
//  FirstViewController.swift
//  Food
//
//  Created by 유연탁 on 2022/07/08.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    @IBOutlet weak var bamin1View: UIView!
    @IBOutlet weak var takeOutView: UIView!
    @IBOutlet weak var bMartView: UIView!
    @IBOutlet weak var shoppingLiveView: UIView!
    @IBOutlet weak var presentView: UIView!
    @IBOutlet weak var countryFoodView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var couponButton: UIButton!
    @IBOutlet weak var giftButton: UIButton!
    @IBOutlet weak var pickButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designView()
        designButton()
        designBanner()
        // Do any additional setup after loading the view.
    }
    
    func designView() {
        topView.layer.cornerRadius = 8
        deliveryView.layer.cornerRadius = 8
        bamin1View.layer.cornerRadius = 8
        takeOutView.layer.cornerRadius = 8
        bMartView.layer.cornerRadius = 8
        shoppingLiveView.layer.cornerRadius = 8
        presentView.layer.cornerRadius = 8
        countryFoodView.layer.cornerRadius = 8
    }

    func designBanner() {
        bannerImageView.layer.cornerRadius = 8
        bannerImageView.image = UIImage(named: "banner0\(Int.random(in: 1...3))")
    }
    
    func designButton() {
        pointButton.titleLabel?.font = .systemFont(ofSize: 11, weight: .medium)
        couponButton.titleLabel?.font = .systemFont(ofSize: 11, weight: .medium)
        giftButton.titleLabel?.font = .systemFont(ofSize: 11, weight: .medium)
        pickButton.titleLabel?.font = .systemFont(ofSize: 11, weight: .medium)
    }
}
