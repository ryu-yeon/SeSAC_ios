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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.image = UIImage(named: "movie\(Int.random(in: 1...20))")
        imageView2.image = UIImage(named: "movie\(Int.random(in: 1...20))")
        imageView3.image = UIImage(named: "movie\(Int.random(in: 1...20))")
        imageView4.image = UIImage(named: "movie\(Int.random(in: 1...20))")
        
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
        imageView1.image = UIImage(named: "movie\(Int.random(in: 1...20))")
        imageView2.image = UIImage(named: "movie\(Int.random(in: 1...20))")
        imageView3.image = UIImage(named: "movie\(Int.random(in: 1...20))")
        imageView4.image = UIImage(named: "movie\(Int.random(in: 1...20))")
    }
    
}

