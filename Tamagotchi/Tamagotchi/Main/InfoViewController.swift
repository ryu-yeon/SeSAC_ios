//
//  InfoViewController.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit

class InfoViewController: UIViewController {

    var selectTamagochi: Tamagotchi?
    
    @IBOutlet var infoView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lineView: UIView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tamagotchi = selectTamagochi else {
            print("selectTamagochi error")
            return
        }
        setInfoViewDesign(tamagotchi)
    }

    //MARK: - 텝제스쳐 or 취소버튼 클릭 설정
    @IBAction func goToBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //MARK: - Start 버튼 클릭 설정
    @IBAction func startButtonClicked(_ sender: UIButton) {
        
        guard let tamagotchi = selectTamagochi else {
            print("selectTamagochi error")
            return
        }
        let nickname = UserDefaultsHelper.standard.nickname
        
        UserDefaultsHelper.standard.start = true
        UserDefaultsHelper.standard.nickname = nickname
        UserDefaultsHelper.standard.tamagotchiNumber = tamagotchi.number
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: StoryboardName.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: MainViewController.reusableIenditifier) as! MainViewController
        let nav = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    //MARK: - InfoView UI 설정
    func setInfoViewDesign(_ tamagotchi: Tamagotchi) {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        infoView.layer.cornerRadius = 20
        infoView.clipsToBounds = true
        infoView.backgroundColor = .myBackgroundColor
        
        imageView.image = UIImage(named: "\(tamagotchi.number)-6")
        
        nameLabel.text = tamagotchi.name
        nameLabel.setText(textFont: .boldSystemFont(ofSize: 14))
        nameLabel.setBorderRound()
        
        lineView.backgroundColor = .myMainColor
                
        infoLabel.setText(textFont: .systemFont(ofSize: 12, weight: .semibold))
        infoLabel.numberOfLines = 0
        infoLabel.text = tamagotchi.introduction
        
        setButtonDesign()
    }
    
    //MARK: - 버튼 UI 설정
    func setButtonDesign() {
        let isStart = UserDefaultsHelper.standard.start
        let startButtonTitle = isStart ? "변경하기" : "시작하기"
        
        startButton.setButton(title: "\(startButtonTitle)", image: UIImage(), textFont: .boldSystemFont(ofSize: 14))
        startButton.layer.addBorder([.top], color: UIColor.myMainColor ?? .black, width: 0.3)
        
        cancelButton.setButton(title: "취소", image: UIImage(), textFont: .boldSystemFont(ofSize: 14))
        cancelButton.backgroundColor = .myBackgroundColor2
        cancelButton.layer.addBorder([.top], color: UIColor.myMainColor ?? .black, width: 0.3)
    }
}
