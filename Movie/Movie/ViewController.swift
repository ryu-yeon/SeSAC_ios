//
//  ViewController.swift
//  Movie
//
//  Created by 유연탁 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!

    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arr = (1...20).map{$0}
        
        let firstMovie = arr.remove(at: Int.random(in: 0...19))
        let secondMovie = arr.remove(at: Int.random(in: 0...18))
        let thirdMovie = arr.remove(at: Int.random(in: 0...17))
        let fourthMovie = arr.remove(at: Int.random(in: 0...16))
        
        imageView1.image = UIImage(named: "movie\(firstMovie)")
        imageView2.image = UIImage(named: "movie\(secondMovie)")
        imageView3.image = UIImage(named: "movie\(thirdMovie)")
        imageView4.image = UIImage(named: "movie\(fourthMovie)")
        
        imageView1.layer.cornerRadius = 110/2
        imageView2.layer.cornerRadius = 110/2
        imageView3.layer.cornerRadius = 110/2

        imageView1.layer.borderWidth = 2
        imageView2.layer.borderWidth = 2
        imageView3.layer.borderWidth = 2
        
        imageView1.layer.borderColor = UIColor.white.cgColor
        imageView2.layer.borderColor = UIColor.white.cgColor
        imageView3.layer.borderColor = UIColor.white.cgColor

    }

    @IBAction func playButtonClicked(_ sender: UIButton) {
        var arr = (1...20).map{$0}
        
        let firstMovie = arr.remove(at: Int.random(in: 0...19))
        let secondMovie = arr.remove(at: Int.random(in: 0...18))
        let thirdMovie = arr.remove(at: Int.random(in: 0...17))
        let fourthMovie = arr.remove(at: Int.random(in: 0...16))
        
        imageView1.image = UIImage(named: "movie\(firstMovie)")
        imageView2.image = UIImage(named: "movie\(secondMovie)")
        imageView3.image = UIImage(named: "movie\(thirdMovie)")
        imageView4.image = UIImage(named: "movie\(fourthMovie)")
    }
    
}

