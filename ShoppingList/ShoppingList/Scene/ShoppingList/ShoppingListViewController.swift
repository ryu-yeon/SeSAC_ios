//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

import RealmSwift

class ShoppingListViewController: BaseViewController {
    
    let mainView = ShoppingListView()
    
    let localRealm = try! Realm()
    
    var tasks: Results<ShoppingList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Shopping List"
        
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "registerDate", ascending: false)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.reuableIdentifier)
    }
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func configure() {
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    @objc func addButtonClicked() {
        
        if let shoppingItem = mainView.userTextField.text, mainView.userTextField.text != "" {
            let task = ShoppingList(shoppingItem: shoppingItem, checkItem: false, favoriteItem: false, registerDate: Date())
            try! localRealm.write {
                localRealm.add(task)
            }
        }
        mainView.userTextField.text = ""
        mainView.tableView.reloadData()
        view.endEditing(true)
    }
}


extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.reuableIdentifier, for: indexPath) as! ShoppingListTableViewCell
        
        cell.shoppingListLabel.text = tasks[indexPath.row].shoppingItem
        
        let checkButtonImage = tasks[indexPath.row].checkItem ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        cell.checkButton.setImage(checkButtonImage, for: .normal)
        
        let favoriteButtonImage = tasks[indexPath.row].favoriteItem ? UIImage(systemName: "star.fill") :  UIImage(systemName: "star")
        
        cell.favoriteButton.setImage(favoriteButtonImage, for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
