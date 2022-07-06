//
//  BoardViewController.swift
//  LEDBoard
//
//  Created by 유연탁 on 2022/07/06.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTextField.placeholder = "내용을 작성해주세요."
        userTextField.text = "안녕하세요"
        userTextField.keyboardType = .emailAddress
        
        sendButton.setTitle("전송", for: .normal)
        sendButton.setTitle("빨리보내!", for: .highlighted)
        sendButton.backgroundColor = .yellow
        sendButton.layer.cornerRadius = 5
        sendButton.layer.borderWidth = 2
        sendButton.layer.borderColor = UIColor.green.cgColor
        sendButton.setTitleColor(.red, for: .normal)
        sendButton.setTitleColor(.blue, for: .highlighted)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        resultLabel.text = userTextField.text
    }
    
    @IBAction func textColorButtonClicked(_ sender: UIButton) {
        resultLabel.textColor = .red
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
