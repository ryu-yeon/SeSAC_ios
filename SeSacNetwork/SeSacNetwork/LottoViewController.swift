//
//  LottoViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {


    @IBOutlet var lottoList: [UILabel]!
    @IBOutlet weak var lottoBonus: UILabel!
    
    @IBOutlet var numberTextField: UITextField!
//    @IBOutlet var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView()
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있습니다!
    
    let numberList: [Int] = (1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoBonus.textColor = .blue
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        numberTextField.text = "1025회차"
        requestLotto(1025)
    }
    
    func requestLotto(_ number: Int) {
        
        //AF: 200~299 status code
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")

                var number: Int = 1
                
                for i in self.lottoList {
                    i.text = json["drwtNo\(number)"].stringValue
                    number += 1
                }
                self.lottoBonus.text = json["bnusNo"].stringValue
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(numberList[row])회차"
        requestLotto(numberList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회"
    }
    
}
