//
//  ViewController.swift
//  DayCalculator
//
//  Created by 유연탁 on 2022/07/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var d100Label: UILabel!
    @IBOutlet weak var d200Label: UILabel!
    @IBOutlet weak var d300Label: UILabel!
    @IBOutlet weak var d400Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        designImageView()
    }
    
    func designImageView() {
        imageView1.layer.cornerRadius = 20
        imageView1.transform = imageView1.transform.rotated(by: .pi/2)
        imageView2.layer.cornerRadius = 20
        imageView2.transform = imageView2.transform.rotated(by: .pi/2)
        imageView3.layer.cornerRadius = 20
        imageView3.transform = imageView3.transform.rotated(by: .pi/2)
        imageView4.layer.cornerRadius = 20
        imageView4.transform = imageView4.transform.rotated(by: .pi/2)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
    }
    
}

