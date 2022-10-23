//
//  DiffableCollectionViewController.swift
//  FireBaseExample
//
//  Created by 유연탁 on 2022/10/19.
//

import UIKit

import Kingfisher

class DiffableCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = DiffableViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        collectionView.delegate = self
        searchBar.delegate = self
        
        viewModel.photoList.bind { photo in
            var snapshop = NSDiffableDataSourceSnapshot<Int, SearchResult>()
            snapshop.appendSections([0])
            snapshop.appendItems(photo.results)
            self.dataSource.apply(snapshop)
        }
    }
}

extension DiffableCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//        let alert = UIAlertController(title: item, message: "클릭!", preferredStyle: .alert)
//
//        let ok = UIAlertAction(title: "확인", style: .cancel)
//        alert.addAction(ok)
//        present(alert, animated: true)
    }
}

extension DiffableCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {

        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }

    private func configureDataSource() {
        let cellregiteration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"

            //String > URL > Data > Image
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)
                let data = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
            
            var backgournd = UIBackgroundConfiguration.listPlainCell()
            backgournd.strokeWidth = 2
            backgournd.strokeColor = .brown
            cell.backgroundConfiguration = backgournd
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellregiteration, for: indexPath, item: itemIdentifier)
            return cell
        })

    }
}

extension DiffableCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        viewModel.requestSearchPhoto(query: searchBar.text!)
    }
}
