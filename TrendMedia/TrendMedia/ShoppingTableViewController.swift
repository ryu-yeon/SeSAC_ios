//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var searchView: UIView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var userTextField: UITextField!
    
    var shoppingListArray: [String] = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    var checkBoxArray: [Bool] = [true, false, false, false]
    var starArray: [Bool] = [true, false, true, true]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.backgroundColor = #colorLiteral(red: 0.913924396, green: 0.9139244556, blue: 0.913924396, alpha: 1)
        searchView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 5
        tableView.rowHeight = 48

    }
    
    @IBAction func userTextFieldReturn(_ sender: Any) {
        shoppingListArray.append(userTextField.text!)
        checkBoxArray.append(false)
        starArray.append(false)
        view.endEditing(true)
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        
        cell.itemLabel.text = shoppingListArray[indexPath.row]
               
        if checkBoxArray[indexPath.row] {
            cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        if starArray[indexPath.row] {
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        cell.itemView.backgroundColor = #colorLiteral(red: 0.913924396, green: 0.9139244556, blue: 0.913924396, alpha: 1)
        cell.itemView.layer.cornerRadius = 10
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingListArray.remove(at: indexPath.row)
            checkBoxArray.remove(at: indexPath.row)
            starArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
