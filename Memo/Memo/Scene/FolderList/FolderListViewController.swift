//
//  FolderListViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

class FolderListViewController: BaseViewController {
    
    private let mainView = FolderListView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    let list = ["aasdasd", "asdjnaisd", "enefn"]
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaultHelper.standard.start {
            UserDefaultHelper.standard.start = true
            let vc = PopUpViewController()
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        
        configureDataSource()
        setToolbarButton()
    }
    
    private func setToolbarButton() {
        
        let view1 = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let view2 = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let createFolder = UIButton()
        createFolder.frame = CGRect(x: 0, y: -24, width: 30, height: 30)
        createFolder.setImage(UIImage(systemName: "folder.badge.plus"), for: .normal)
        createFolder.contentVerticalAlignment = .fill
        createFolder.contentHorizontalAlignment = .fill
        
        let writeButton = UIButton()
        writeButton.frame = CGRect(x: -20, y: -24, width: 30, height: 30)
        writeButton.setImage(UIImage.writeImage, for: .normal)
        writeButton.contentVerticalAlignment = .fill
        writeButton.contentHorizontalAlignment = .fill
        
        view1.addSubview(createFolder)
        view2.addSubview(writeButton)
        
        createFolder.addTarget(self, action: #selector(createFolderButtonClicked), for: .touchUpInside)
        writeButton.addTarget(self, action: #selector(writeButtonClicked), for: .touchUpInside)
        mainView.toolBar.items = [UIBarButtonItem(customView: view1), UIBarButtonItem.flexibleSpace(),  UIBarButtonItem(customView: view2)]
        
    }
    
    @objc func createFolderButtonClicked() {
        
    }
    
    @objc func writeButtonClicked() {
        let vc = WriteViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FolderListViewController {
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(list)
        dataSource.apply(snapshot)
    }
}
