//
//  NewsViewController.swift
//  RxSwiftTest
//
//  Created by 유연탁 on 2022/10/26.
//

import UIKit

import RxCocoa
import RxSwift

class NewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var viewModel = NewsViewModel()
    let disposeBag = DisposeBag()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, News.NewsItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureDataSource()
        bindData()
        configureViews()
    }
    
    func bindData() {
        viewModel.sample
            .withUnretained(self)
            .bind { (vc, item) in
            var snapshot = NSDiffableDataSourceSnapshot<Int, News.NewsItem>()
            snapshot.appendSections([0])
            snapshot.appendItems(item)
            vc.dataSource.apply(snapshot, animatingDifferences: false)
        }
            .disposed(by: disposeBag)

        numberTextField.rx.text
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.loadSample()
            }
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.resetSample()
            }
            .disposed(by: disposeBag)
        
        viewModel.pageNumber.bind { value in
            self.numberTextField.text = value
        }
        .disposed(by: disposeBag)
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
