//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/22.
//

import UIKit

class ShoppingListViewController: BaseViewController {
    
    let mainView = ShoppingListView()
    
    var shoppingList: [String] = ["1", "2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Shopping List"
        
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
            shoppingList.append(shoppingItem)
        }
        mainView.userTextField.text = ""
        mainView.tableView.reloadData()
        view.endEditing(true)
    }
}


extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.reuableIdentifier, for: indexPath) as! ShoppingListTableViewCell
        
        cell.shoppingListLabel.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
