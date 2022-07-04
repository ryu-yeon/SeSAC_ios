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

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView1.layer.cornerRadius = 110/2
        imageView2.layer.cornerRadius = 110/2
        imageView3.layer.cornerRadius = 110/2
        view1.layer.cornerRadius = 115/2
        view2.layer.cornerRadius = 115/2
        view3.layer.cornerRadius = 115/2

    }


}

