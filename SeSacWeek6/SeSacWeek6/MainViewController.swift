//
//  MainViewController.swift
//  SeSacWeek6
//
//  Created by 유연탁 on 2022/08/09.
//

import UIKit

import Kingfisher

/*
 tableVIew - CollctionView > 프로토콜
 tag
 */

/*
 awakeFromNib - 셀 UI 초기화, 재사용 매커니즘에 의해 일정 횟수 이상 호출되지 않음.
 cellForRowAt - 재사용 될 때마다, 사용자에게 보일 때 마다 항상 실행됨.
            - 화면과 데이터는 별개, 모든 indexPath.item에 대한 조건이 없다면 재사용 시 오류가 발생할 수 있음.
 prepareForReuse - 셀이 재사용 될 때 초기화 하고자 하는 값을 넣으면 오류를 해결할 수 있음. 즉, cellForRowAt에서 모든 indexPath.item에 대한 조건을 작성하지 않아도 됨!
 
 ColletcionView in TableView
 - 하나의 컬렉션뷰나 테이블뷰라면 문제 X
 - 복합적인 구조라면, 테이블뷰도 재사용 되어야 하고 컬렉션셀도 재사용이 되어야 함
 - Index > reloadData()
 */

class MainViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var mainTableView: UITableView!
    
    let color: [UIColor] = [.green, .darkGray, .yellow, .blue, .black]
    
    let numberList: [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](120...130),
        [Int](175...185),
        [Int](4000...4016),
        [Int](1000...1026)
    ]
    
    var episodeList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
        bannerCollectionView.isPagingEnabled = true //device width
       
        TMDBAPIManager.shared.requestImage { posterList in
            dump(posterList)
            //1. 네트워크 통신
            //2. 배열생성
            //3. 배열담기
            //4. 뷰 등에 표현
            self.episodeList = posterList
            self.mainTableView.reloadData()
        }
        
    }
}

//하나의 프로토콜, 매서드에서 여러 컬렌션뷰의 delegate, dataSource 구현해야 함
//셀이 재사용 되면 특정 collectionView 셀을 재사용하게 될 수 있음.
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : episodeList[collectionView.tag].count
    }
    
    //bannerCollctionView or tableView 안에 들어있는 컬렉션뷰
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        print("MainViewController", #function, indexPath)

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell()}
        
        
        if collectionView == bannerCollectionView {
            cell.cardView.posterImageView.backgroundColor = color[indexPath.item]
        } else {
            cell.cardView.posterImageView.backgroundColor = .black
            cell.cardView.contentLabel.textColor = .white
            let url = URL(string: TMDBAPIManager.shared.imageURL + episodeList[collectionView.tag][indexPath.item])
            cell.cardView.posterImageView.kf.setImage(with: url)
            cell.cardView.contentLabel.text = ""
        }
        
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        let width = UIScreen.main.bounds.width
        let height = bannerCollectionView.frame.height
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //내부 매개변수 tableView를 통해 테이블뷰를 특정
    //테이블뷰 객체가 하나 일 경우에는 내부 매개변수를 활용하지 않아도 문제가 생기지 않는다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else { return  UITableViewCell() }
    
//        print("MainViewController", #function, indexPath)
    
        
        cell.backgroundColor = .yellow
        
        cell.titleLabel.text = TMDBAPIManager.shared.tvList[indexPath.section].0
        cell.contentCollectionView.backgroundColor = .lightGray
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.tag = indexPath.section //각 셀 구분 짓기!
        
        cell.contentCollectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)

        cell.contentCollectionView.reloadData() //Index Out of Range 해결
        
        return cell
    }
    
}
