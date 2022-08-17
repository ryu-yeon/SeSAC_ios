//
//  FirstViewController.swift
//  SeSacWeek7Diary
//
//  Created by 유연탁 on 2022/08/16.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tutorialLabel.backgroundColor = .red
        tutorialLabel.numberOfLines = 0
        tutorialLabel.font = .boldSystemFont(ofSize: 25)
        tutorialLabel.text = """
        일기 씁시다!
        잘 써봅시다!
        """
        
        imageView.image = UIImage(systemName: "star.fill")
        
        blackView.backgroundColor = .black
        blackView.alpha = 0
        tutorialLabel.alpha = 0
                
        UIView.animate(withDuration: 3) {
            self.tutorialLabel.alpha = 1
            self.tutorialLabel.backgroundColor = .yellow
            animateBlackView()
            animateStarView()
        } completion: { _ in 
            print("Complete")
        }

        func animateBlackView() {
            UIView.animate(withDuration: 3) {
                self.blackView.transform = CGAffineTransform(scaleX: 3, y: 1)
                self.blackView.alpha = 1
            } completion: { _ in
                
            }
            
        }
        
        func animateStarView() {
            UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse]) {
                self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.imageView.tintColor = .green
            } completion: { _ in
                
            }

        }
        
    }

}
