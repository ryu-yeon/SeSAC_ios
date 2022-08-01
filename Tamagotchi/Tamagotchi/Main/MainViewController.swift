//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit
import IQKeyboardManagerSwift
import Toast

class MainViewController: UIViewController {

    let talkList = TalkList()
    let tamagotchiInfo = TamagotchiInfo()
    let tamagotchiNumber = UserDefaults.standard.integer(forKey: "tamagotchi")
    var nickname: String?
    var level = 1
    var food = 0
    var water = 0
    var foodCount = 0
    var waterCount = 0
    
    @IBOutlet var talkBoxImageview: UIImageView!
    @IBOutlet var talkLabel: UILabel!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var lineView1: UIView!
    @IBOutlet var lineView2: UIView!
    @IBOutlet var foodButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    @IBOutlet var foodTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.array(forKey: "data") as? [Int] {
            level = data[0]
            food = data[1]
            water = data[2]
        }
        foodButton.tag = 0
        waterButton.tag = 1
        setNavigationBar(title: "\(nickname ?? "대장님")의 다마고치")
        setNavigationBarItem()
        setMainViewDesign()
    }
    
    //MARK: - ViewWillApear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        foodCount = 0
        waterCount = 0
        nickname = UserDefaults.standard.string(forKey: "nickname")
        navigationItem.title = "\(nickname ?? "대장님")의 다마고치"
        talkLabel.text = talkList.normal.randomElement()
    }

    //MARK: - 세팅버튼 클릭 설정
    @objc func goToSetting(){
        let sb = UIStoryboard(name: StoryboardName.setting, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.reusableIenditifier) as! SettingTableViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
   
    //MARK: - Food & Water 버튼 클릭 설정
    @IBAction func buttonClicked(_ sender: UIButton) {
        if sender.tag == 0 {
            if (foodTextField.text ?? "").isEmpty {
                foodCount += 1
                food += 1
            } else {
                guard let input = Int(foodTextField.text ?? "") else {
                    self.view.makeToast("숫자를 입력해주세요!", duration: 1, position: .center)
                    foodTextField.text = ""
                    view.endEditing(true)
                    return
                }
                if input < 100 && input > 0 {
                    food += input
                    foodCount += input
                }
                else {
                    self.view.makeToast("밥알은 99개까지 먹을 수 있습니다!", duration: 1, position: .center)
                }
            }
            updateUI()
            if foodCount > 100 {
                talkLabel.text = talkList.stopFood.randomElement()
            } else {
                talkLabel.text = talkList.food.randomElement()
            }
            foodTextField.text = ""
        }
        else {
            if (waterTextField.text ?? "").isEmpty {
                waterCount += 1
                water += 1
            } else {
                guard let input = Int(waterTextField.text ?? "") else {
                    self.view.makeToast("숫자를 입력해주세요!", duration: 1, position: .center)
                    waterTextField.text = ""
                    view.endEditing(true)
                    return
                }
                if input < 50 && input > 0 {
                    water += input
                    waterCount += input
                }
                else {
                    self.view.makeToast("물방울은 49개까지 먹을 수 있습니다!", duration: 1, position: .center)
                }
            }
            updateUI()
            if waterCount > 50 {
                talkLabel.text = talkList.stopWater.randomElement()
            } else {
                talkLabel.text = talkList.water.randomElement()
            }
            waterTextField.text = ""
        }
        view.endEditing(true)
    }
    
    //MARK: - 탭제스쳐 설정
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - Upadate 설정
    func updateUI() {
        level = levelCalculate()
        
        tamagotchiImageView.image = level == 10 ? UIImage(named: "\(tamagotchiNumber)-9") : UIImage(named: "\(tamagotchiNumber)-\(level)")
        infoLabel.text = "LV\(level) · 밥알 \(food)개 · 물방울 \(water)개"
        UserDefaults.standard.set([level, food, water], forKey: "data")
    }
    
    //MARK: - Level 계산 설정
    func levelCalculate() -> Int {
        let exp: Double = (Double(food) / 5) + (Double(water) / 2)
        switch exp {
        case 0...19:
            return 1
        case 20...29:
            return 2
        case 30...39:
            return 3
        case 40...49:
            return 4
        case 50...59:
            return 5
        case 60...69:
            return 6
        case 70...79:
            return 7
        case 80...89:
            return 8
        case 90...99:
            return 9
        default:
            return 10
        }
    }
    
    //MARK: - NavigationBarItem 설정
    func setNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(goToSetting))
        navigationItem.backButtonTitle = " "
        navigationController?.navigationBar.layer.addBorder([.bottom], color: UIColor.myMainColor ?? .black, width: 0.3)
        navigationController?.navigationBar.layer.addTopBorder([.top], color: UIColor.myBackgroundColor ?? .white, width: 50)
    }
    
    //MARK: - MainView UI 설정
    func setMainViewDesign() {
        view.backgroundColor = .myBackgroundColor
        
        talkBoxImageview.backgroundColor = .myBackgroundColor
        talkBoxImageview.image = UIImage(named: "bubble")
        
        tamagotchiImageView.image = level == 10 ? UIImage(named: "\(tamagotchiNumber)-9") : UIImage(named: "\(tamagotchiNumber)-\(level)")
        
        talkLabel.numberOfLines = 0
        talkLabel.setText(textFont: .boldSystemFont(ofSize: 14))
        talkLabel.backgroundColor = .clear
        
        nameLabel.text = tamagotchiInfo.tamagotchi[tamagotchiNumber].name
        nameLabel.setText(textFont: .boldSystemFont(ofSize: 15))
        nameLabel.setBorderRound()
        nameLabel.backgroundColor = .myBackgroundColor2
        
        infoLabel.text = "LV\(level) · 밥알 \(food)개 · 물방울 \(water)개"
        infoLabel.setText(textFont: .boldSystemFont(ofSize: 14))
        
        foodTextField.textAlignment = .center
        foodTextField.placeholder = "밥주세용"
        foodTextField.borderStyle = .none
        foodTextField.keyboardType = .numberPad
        
        foodButton.setBorderRound()
        foodButton.setButton(title: " 밥먹기", image: UIImage(systemName: "leaf.circle")!, textFont: .boldSystemFont(ofSize: 12))

        waterTextField.textAlignment = .center
        waterTextField.placeholder = "물주세용"
        waterTextField.borderStyle = .none
        waterTextField.keyboardType = .numberPad
        
        waterButton.setBorderRound()
        waterButton.setButton(title: " 물먹기", image: UIImage(systemName: "drop.circle")!, textFont: .boldSystemFont(ofSize: 12))
        
        lineView1.backgroundColor = .myMainColor
        lineView2.backgroundColor = .myMainColor
    }
}
