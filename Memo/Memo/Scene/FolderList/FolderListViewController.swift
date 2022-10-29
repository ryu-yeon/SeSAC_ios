//
//  FolderListViewController.swift
//  Memo
//
//  Created by 유연탁 on 2022/10/20.
//

import UIKit

import RxCocoa
import RxSwift

class FolderListViewController: BaseViewController {
    
    private let mainView = FolderListView()
    private let viewModel = FolderListViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onBoarding()
        bind()
        setToolbarButton()
        setNavigtaionTitle(title: "폴더")
        setNavigtaionBar()
        setSearchController()
        
        mainView.tableView.rx.itemSelected
            .withUnretained(self)
            .bind { (vc, indexPath) in
                let nextVC = MemoListViewController()

                nextVC.viewModel.folder = vc.viewModel.tasks[indexPath.item]
                vc.navigationController?
                    .pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        mainView.tableView.rx.itemDeleted
            .withUnretained(self)
            .bind { (vc, indexPath) in
                vc.viewModel.removeFolder(index: indexPath.row)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch()
    }
    
    private func bind() {
        viewModel.list
            .bind(to: mainView.tableView.rx.items(cellIdentifier: FolderListTableViewCell.reusableIdentifier, cellType: FolderListTableViewCell.self)) {
                (item, element, cell) in
                cell.titleLabel.text = element.title
                cell.countLabel.text = "\(element.memo.count)"
            }
            .disposed(by: disposeBag)
        
        viewModel.fetch()
    }
    
    private func onBoarding() {
        if !UserDefaultHelper.standard.start {
            UserDefaultHelper.standard.start = true
            viewModel.saveFolder()
            let vc = PopUpViewController()
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    private func setToolbarButton() {
        let createFolderButton = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"))
        
        let writeButton = UIBarButtonItem(image: UIImage.writeImage)
        
        createFolderButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                let nextVC = UINavigationController(rootViewController: CreateFolderViewController())
                
                nextVC.modalPresentationStyle = .fullScreen
                vc.present(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        writeButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                let nextVC = WriteViewController()
                nextVC.viewModel.folder = vc.viewModel.tasks.first
                vc.navigationController?.pushViewController(nextVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        mainView.toolBar.items = [createFolderButton, .flexibleSpace(), writeButton]
        
    }
}
