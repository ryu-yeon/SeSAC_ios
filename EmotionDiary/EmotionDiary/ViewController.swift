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
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    var emotionCount = Array(repeating: 0, count: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let save =  UserDefaults.standard.array(forKey: "emotionCount") as? [Int] {
            emotionCount = save
            print("완료")
        }
        displayLabel()
        designResetButton()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UserDefaults.standard.set(emotionCount, forKey: "emotionCount")
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        emotionCount[sender.tag] += 1
        displayLabel()
    }
    
    func designResetButton() {
        resetButton.customView?.layer.cornerRadius = 15
        resetButton.customView?.layer.borderWidth = 2
        resetButton.customView?.layer.borderColor = UIColor.black.cgColor
    }
    
    func displayLabel() {
        label1.text = "행복해 \(emotionCount[0])"
        label2.text = "좋아해 \(emotionCount[1])"
        label3.text = "사랑해 \(emotionCount[2])"
        label4.text = "분노해 \(emotionCount[3])"
        label5.text = "밍밍해 \(emotionCount[4])"
        label6.text = "하품해 \(emotionCount[5])"
        label7.text = "당황해 \(emotionCount[6])"
        label8.text = "우울해 \(emotionCount[7])"
        label9.text = "속상해 \(emotionCount[8])"
    }
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        emotionCount = Array(repeating: 0, count: 9)
        displayLabel()
    }
}

