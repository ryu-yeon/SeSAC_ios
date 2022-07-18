//
//  ViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
 
    

    @IBOutlet var dateLabelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in dateLabelCollection {
//            print(i.text ?? "")
        }
    }

    
    func configureLabelDesign() {
        for i in dateLabelCollection {
            i.font = .boldSystemFont(ofSize: 20)
            i.textColor = .brown
        }
        
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
    }
    
}

