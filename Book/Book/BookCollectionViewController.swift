//
//  BookCollectionViewController.swift
//  Book
//
//  Created by 유연탁 on 2022/07/21.
//

import UIKit
import Kingfisher

class BookCollectionViewController: UICollectionViewController {

    let bookInfo = BookInfo()
    
    let colorArray: [UIColor] = [.systemOrange, .systemPink, .systemPurple, .systemIndigo, .systemGray, .systemCyan, .systemTeal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
        
        navigationItem.title = "도서"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(goToSearchView))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }

    @objc func goToSearchView() {
        
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookInfo.book.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        
        cell.bookTitleLabel.text = bookInfo.book[indexPath.row].bookTitle
        cell.bookTitleLabel.font = .boldSystemFont(ofSize: 16)
        cell.bookTitleLabel.textColor = .white
        
        cell.bookRateLabel.text = "\(bookInfo.book[indexPath.row].bookRate)"
        cell.bookRateLabel.textColor = .white
        cell.bookImageView.kf.setImage(with: URL(string: bookInfo.book[indexPath.row].bookImageURL))

        cell.bookView.layer.cornerRadius = 30
        cell.bookView.backgroundColor = colorArray.randomElement()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookInfoViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
