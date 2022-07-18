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
    
    var emotionCountArray = Array(repeating: 0, count: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let save =  UserDefaults.standard.array(forKey: "emotionCountArray") as? [Int] {
            emotionCountArray = save
        }
        displayLabel()
        designResetButton()
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        UserDefaults.standard.set(emotionCountArray, forKey: "emotionCountArray")
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        emotionCountArray[sender.tag] += 1
        displayLabel()
    }
    
    func designResetButton() {
        resetButton.customView?.layer.cornerRadius = 15
        resetButton.customView?.layer.borderWidth = 2
        resetButton.customView?.layer.borderColor = UIColor.black.cgColor
    }
    
    func displayLabel() {
        label1.text = "행복해 \(emotionCountArray[0])"
        label2.text = "좋아해 \(emotionCountArray[1])"
        label3.text = "사랑해 \(emotionCountArray[2])"
        label4.text = "분노해 \(emotionCountArray[3])"
        label5.text = "밍밍해 \(emotionCountArray[4])"
        label6.text = "하품해 \(emotionCountArray[5])"
        label7.text = "당황해 \(emotionCountArray[6])"
        label8.text = "우울해 \(emotionCountArray[7])"
        label9.text = "속상해 \(emotionCountArray[8])"
    }
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        emotionCountArray = Array(repeating: 0, count: 9)
        displayLabel()
    }
}

