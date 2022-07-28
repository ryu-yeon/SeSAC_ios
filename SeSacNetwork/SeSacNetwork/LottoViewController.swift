//
//  LottoViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/28.
//

import UIKit

class LottoViewController: UIViewController {


    @IBOutlet var numberTextField: UITextField!
//    @IBOutlet var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView()
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있습니다!
    
    let numberList: [Int] = (1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView

        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
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
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회"
    }
    
}
