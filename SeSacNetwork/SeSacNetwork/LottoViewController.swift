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
    let format = DateFormatter()
    
    var round = 0
    var numberList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let first = format.date(from: "2002-12-07 20:35:00")!
        
        round = Int(first.timeIntervalSinceNow / 86400 / 7 * -1) + 1
        numberList = (0...round).reversed()
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        numberTextField.textContentType = .oneTimeCode
        
        lottoBonus.textColor = .blue
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        numberTextField.text = "\(round)회차"
        requestLotto(round)
    }
    
    func requestLotto(_ number: Int) {
        
        //AF: 200~299 status code
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

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
