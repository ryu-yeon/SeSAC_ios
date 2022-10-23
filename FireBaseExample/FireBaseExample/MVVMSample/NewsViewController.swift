//
//  NewsViewController.swift
//  FireBaseExample
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var viewModel = NewsViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureDataSource()
        bindData()
        configureViews()
    }
    
    func bindData() {
        viewModel.sample.bind { item in
            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
            snapshot.appendSections([0])
            snapshot.appendItems(item)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
        
        viewModel.pageNumber.bind { value in
            self.numberTextField.text = value
        }
    }
    
    func configureViews() {
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadButtonClikced), for: .touchUpInside)
    }
    
    @objc func numberTextFieldChanged() {
        guard let text = numberTextField.text else { return }
        viewModel.changePageNumberFormat(text: text)
    }
    
    @objc func resetButtonClicked() {
        viewModel.resetSample()
    }
    
    @objc func loadButtonClikced() {
        viewModel.loadSample()
    }
}

extension NewsViewController {
    
    func configureHierachy() { //addSubView, init, snapkit
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .lightGray
    }
    
    func configureDataSource() {
        let cellRegistrataion = UICollectionView.CellRegistration<UICollectionViewListCell, News.NewsItem> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.body
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistrataion, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
}
