//
//  NflixViewController.swift
//  CodeBaseUI
//
//  Created by 유연탁 on 2022/08/20.
//

import UIKit

class NflixViewController: BaseViewController {
    
    let mainView = NflixView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = mainView
        var number = (1...20).map{$0}.shuffled()
        mainView.thunailMovieImageView1.image = UIImage(named: "moive\(number.removeFirst())")
        mainView.thunailMovieImageView2.image = UIImage(named: "movie\(number.removeFirst())")
        mainView.thunailMovieImageView3.image = UIImage(named: "movie\(number.removeFirst())")
        mainView.posterImageView.image = UIImage(named: "movie\(number.removeFirst())")
    }
    
    override func configure() {
        mainView.playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
    }

    @objc func playButtonClicked() {
        var number = (1...20).map{$0}.shuffled()
        mainView.thunailMovieImageView1.image = UIImage(named: "moive\(number.removeLast())")
        mainView.thunailMovieImageView2.image = UIImage(named: "movie\(number.removeLast())")
        mainView.thunailMovieImageView3.image = UIImage(named: "movie\(number.removeFirst())")
    }
}
