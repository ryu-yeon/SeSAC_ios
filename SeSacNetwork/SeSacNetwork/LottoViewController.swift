//
//  LottoViewController.swift
//  SeSacNetwork
//
//  Created by 유연탁 on 2022/07/28.
//

import UIKit

class LottoViewController: UIViewController {

    @IBOutlet var lottoList: [UILabel]!
    @IBOutlet weak var lottoBonus: UILabel!
    
    @IBOutlet var numberTextField: UITextField!
//    @IBOutlet var lottoPickerView: UIPickerView!
    
    var lottoPickerView = UIPickerView()
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있습니다!
    let format = DateFormatter()
    
    var round = 0
    var roundList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let firstRound = format.date(from: "2002-12-07 20:35:00")!
        
        round = Int(firstRound.timeIntervalSinceNow / 86400 / 7 * -1) + 1
        roundList = (0...round).reversed()
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        numberTextField.textContentType = .oneTimeCode
        
        lottoBonus.textColor = .blue
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        numberTextField.text = "\(round)회차"
        requestLotto(round)
    }
    
    func requestLotto(_ round: Int) {
        
        LottoAPIManager.shared.requestLottoData(round: round) { winningNumbers, bonusNumber in
            
            var number = 0
            
            for i in self.lottoList {
                i.text = winningNumbers[number]
                number += 1
            }
            self.lottoBonus.text = bonusNumber
        }
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roundList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(roundList[row])회차"
        requestLotto(roundList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(roundList[row])회"
    }
    
}
