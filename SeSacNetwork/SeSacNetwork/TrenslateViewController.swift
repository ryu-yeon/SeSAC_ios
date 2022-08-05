//
//  TrenslateViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON
import SwiftUI

//UIButton, UITextField > Action
//UITextView, UISearchBar, UIPickerView > X
//UIControl
//UIResponderChain > resignFirstResponder() / becomeFirstResponder

class TrenslateViewController: UIViewController {

    @IBOutlet var userInputTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        userInputTextView.font = UIFont(name: "HSSantokki", size: 20)
        
        
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        requestTranslate(text: userInputTextView.text)
        view.endEditing(true)
    }
    
    @IBAction func tapgesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func requestTranslate(text: String) {
        
        let url = EndPoint.translateURL
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        let parameters: Parameters = ["source": "ko", "target": "en", "text": text]
        
        AF.request(url, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                print(statusCode)
                if statusCode == 200 {
                    self.resultTextView.text = json["message"]["result"]["translatedText"].stringValue
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }

                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

extension TrenslateViewController: UITextViewDelegate {
    
    //텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    //편집이 시작될 때. 커서가 시작될 때
    //텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝났을 때. 커서가 없어지는 순간
    //텍스트뷰 글자: 사용자가 아무 글자도 안 썼으면 플레이스 홀더 글자 보이게 해!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            userInputTextView.text = textViewPlaceholderText
            userInputTextView.textColor = .lightGray
        }
    }

}
