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
    
    var tasks: Results<ShoppingList>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
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
    
    func fetchRealm() {
        tasks = localRealm.objects(ShoppingList.self).sorted(byKeyPath: "registerDate", ascending: false)
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

        cell.favoriteButton.tag = indexPath.row
        cell.checkButton.tag = indexPath.row
        
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        try! self.localRealm.write {
            self.tasks[sender.tag].checkItem = !self.tasks[sender.tag].checkItem
        }
        self.fetchRealm()
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        try! self.localRealm.write {
            self.tasks[sender.tag].favoriteItem = !self.tasks[sender.tag].favoriteItem
        }
        self.fetchRealm()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let remove = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            try! self.localRealm.write {
                self.localRealm.delete(self.tasks[indexPath.row])
                self.fetchRealm()
            }
            
        }
        remove.image = UIImage(systemName: "trash")
        remove.backgroundColor = .red
        
        
        return UISwipeActionsConfiguration(actions: [remove])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
