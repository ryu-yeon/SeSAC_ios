//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/20.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var moviewList = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonCLicked))
        
    }
    
    @objc func resetButtonCLicked() {
        
        //iOS13+ ScenDelegate 쓸 때 동작하는 코드
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceeDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        sceeDelegate?.window?.rootViewController = vc
        sceeDelegate?.window?.makeKeyAndVisible()
        
    }
      

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviewList.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        let data = moviewList.movie[indexPath.row]
        
        cell.configureCell(data: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "Trend", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RecommandCollectionViewController") as! RecommandCollectionViewController
        
        //2. 값 전달 - vc가 가지고 있는 프로퍼티에 데이터 추가
        vc.movieData = moviewList.movie[indexPath.row]
        
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
