//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by 유연탁 on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    @IBAction func moviewButtonClicked(_ sender: UIButton) {
    
        //화면전환: 스토리보드 파일 -> 스토리보드 내에 뷰컨트롤러 -> 화면 전환
        //영화버튼 클릭 > BucketListTableViewContoller Present
        //1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        //2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.select = sender.currentTitle

        //3.
        self.present(vc, animated: true)
        
        
    }

    
    @IBAction func dramaButtonClicked(_ sender: UIButton) {

        //1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        //2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.select = sender.currentTitle
        
      
        //2.5
        vc.modalPresentationStyle = .fullScreen
        //3.
        self.present(vc, animated: true)
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        //1.
        let storyboard = UIStoryboard(name: "Trend", bundle: nil)
        //2.
        let vc = storyboard.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        
        vc.select = sender.currentTitle
        
        //2.5
        let nav = UINavigationController(rootViewController: vc)
        
        //2.5
        nav.modalPresentationStyle = .fullScreen
        //3.
        self.present(nav, animated: true)
    }
}
