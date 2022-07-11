//
//  ViewController.swift
//  EmotionDiary
//
//  Created by 유연탁 on 2022/07/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    
    
    var count = Array(repeating: 0, count: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        count[Int(sender.currentTitle!)! - 1] += 1
        displayLabel()
    }
    
    func displayLabel() {
        label1.text = "행복해 \(count[0])"
        label2.text = "좋아해 \(count[1])"
        label3.text = "사랑해 \(count[2])"
        label4.text = "분노해 \(count[3])"
        label5.text = "밍밍해 \(count[4])"
        label6.text = "하품해 \(count[5])"
        label7.text = "당황해 \(count[6])"
        label8.text = "우울해 \(count[7])"
        label9.text = "속상해 \(count[8])"
    }
}

