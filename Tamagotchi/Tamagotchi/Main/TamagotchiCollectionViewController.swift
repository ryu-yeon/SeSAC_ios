//
//  TamagotchiCollectionViewController.swift
//  Tamagotchi
//
//  Created by 유연탁 on 2022/07/22.
//

import UIKit
import Toast


class TamagotchiCollectionViewController: UICollectionViewController {
    
    static let identifier = "TamagotchiCollectionViewController"
 
    let tamagotchiData = TamagotchiInfo()
    let tamagotchiCount = TamagotchiInfo().tamagotchi.count - 1
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        setNavigationBar(title: "다마고치 선택하기")
        setCollectionViewLayout()
    }
    
    //MARK: - 컬렉션 뷰 섹션 개수 설정
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 22
    }
    
    //MARK: - 컬렉션 뷰 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TamagotchiCollectionViewCell.identifier, for: indexPath) as! TamagotchiCollectionViewCell

        cell.setDesign(item: indexPath.item, tamagotchiData: tamagotchiData, tamagotchiCount: tamagotchiCount)
        
        return cell
    }

    //MARK: - 컬렉션 뷰 아이템 선택 설정
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item < tamagotchiCount {
           
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: InfoViewController.identifier) as! InfoViewController
            vc.selectTamagochi = tamagotchiData.tamagotchi[indexPath.item + 1]
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
            
        } else {
            self.view.makeToast("준비중입니다! 다른 다마고치를 선택해주세요!", duration: 1, position: .center)
        }
    }
    
    //MARK: - 컬렉션 뷰 레이아웃 설정
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        let height = UIScreen.main.bounds.height - (spacing * 6)
        
        layout.itemSize = CGSize(width: width / 3, height: height / 6)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
}
