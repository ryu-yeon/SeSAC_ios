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
    @IBOutlet weak var textView: UIView!
    @IBOutlet var buttonList: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desginButton(sendButton, buttonTitle: "전송", highlightedTitle: "보내!", buttonColor: .darkGray)
        desginButton(textColorButton, buttonTitle: "변경", highlightedTitle: "완료", buttonColor: .blue)
        designTextField()
        
        resultLabel.numberOfLines = 0
    }
        
    func designTextField() {
        userTextField.placeholder = "내용을 작성해주세요."
        userTextField.text = "안녕하세요"
        userTextField.keyboardType = .emailAddress
        userTextField.borderStyle = .none
        userTextField.textColor = .blue
    }
    
    // buttonOutletVariableName: 외부 매개변수, Argument Label
    // buttonName: 내부 매개변수, Parameter Name
    // _ : 와일드 카드 식별자
    func desginButton(_ buttonName: UIButton, buttonTitle: String, highlightedTitle: String, buttonColor: UIColor) {
        buttonName.setTitle(buttonTitle, for: .normal)
        buttonName.setTitle(highlightedTitle, for: .highlighted)
        buttonName.backgroundColor = buttonColor
        buttonName.layer.cornerRadius = 5
        buttonName.layer.borderWidth = 2
        buttonName.layer.borderColor = UIColor.black.cgColor
        buttonName.setTitleColor(.white, for: .normal)
        buttonName.setTitleColor(.blue, for: .highlighted)
    }
    
    func studyOutletCollection() {
        // 1.반복문
        let buttonArray: [UIButton] = [sendButton, textColorButton]
    
        for item in buttonArray {
            item.backgroundColor = .blue
            item.layer.cornerRadius = 2
        }
        
        // 2.아웃렛 컬렉션
        for item in buttonList {
            item.backgroundColor = .blue
            item.layer.cornerRadius = 2
        }
        
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        textView.isHidden = textView.isHidden ? false : true
        
    }
    
    @IBAction func keyboardDisable(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        resultLabel.text = userTextField.text
    }
    
    @IBAction func textColorButtonClicked(_ sender: UIButton) {
        let colorArray: [UIColor] = [.red, .orange, .yellow, .green, .blue, .white, .black]
        resultLabel.textColor = colorArray[Int.random(in: 0...6)]
    }

}
