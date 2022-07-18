//
//  ViewController.swift
//  NewlyCoinedWord
//
//  Created by 유연탁 on 2022/07/08.
//

import UIKit

enum newlyWord: String {
    case 삼귀다 = "연애를 시작하기 전 썸 단계!"
    case 윰차 = "'유무차별'의 줄임말!"
    case 실매 = "'실시간 매니저'의 줄임말!"
    case 만반잘부 = "'만나서 반가워 잘 부탁해'의 줄임말!"
    case 꾸안꾸 = "'꾸민 듯 안꾸민 듯'의 줄임말!"
    case 구취 = "'구독 취소'의 줄임말!"
    case 어쩔티비 = "'어쩌라고 안 물어봤는데'라는 뜻!"
    case 킹받네 = "'열 받네'의 변형으로 매우 화가 난다는 뜻!"
}

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var hashtagButton1: UIButton!
    @IBOutlet weak var hashtagButton2: UIButton!
    @IBOutlet weak var hashtagButton3: UIButton!
    @IBOutlet weak var hashtagButton4: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        designButton(hashtagButton1)
        designButton(hashtagButton2)
        designButton(hashtagButton3)
        designButton(hashtagButton4)
        designTextField()
        // Do any additional setup after loading the view.
    }

    func designButton(_ button: UIButton) {
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    func designTextField() {
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = .white
        searchTextField.attributedPlaceholder = NSAttributedString(string: "신조어를 입력해주세요!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    @IBAction func hashtagButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
        
        switch sender.currentTitle
        {
        case "삼귀다":
            self.resultLabel.text = newlyWord.삼귀다.rawValue
        case "윰차":
            resultLabel.text = newlyWord.윰차.rawValue
        case "실매":
            self.resultLabel.text = newlyWord.실매.rawValue
        case "만반잘부":
            resultLabel.text = newlyWord.만반잘부.rawValue
        case "꾸안꾸":
            resultLabel.text = newlyWord.꾸안꾸.rawValue
        case "구취":
            self.resultLabel.text = newlyWord.구취.rawValue
        case "어쩔티비":
            resultLabel.text = newlyWord.어쩔티비.rawValue
        case "킹받네":
            resultLabel.text = newlyWord.킹받네.rawValue
        default:
            self.resultLabel.text = "아직 몰라요...ㅠㅠ"
        }
    }
    
    @IBAction func searchWord(_ sender: Any) {
        view.endEditing(true)
        
        switch searchTextField.text
        {
        case "삼귀다":
            self.resultLabel.text = newlyWord.삼귀다.rawValue
        case "윰차":
            resultLabel.text = newlyWord.윰차.rawValue
        case "실매":
            self.resultLabel.text = newlyWord.실매.rawValue
        case "만반잘부":
            resultLabel.text = newlyWord.만반잘부.rawValue
        case "꾸안꾸":
            resultLabel.text = newlyWord.꾸안꾸.rawValue
        case "구취":
            self.resultLabel.text = newlyWord.구취.rawValue
        case "어쩔티비":
            resultLabel.text = newlyWord.어쩔티비.rawValue
        case "킹받네":
            resultLabel.text = newlyWord.킹받네.rawValue
        default:
            self.resultLabel.text = "아직 몰라요...ㅠㅠ"
        }
    }
    
    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
}

