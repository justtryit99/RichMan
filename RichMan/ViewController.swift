//
//  ViewController.swift
//  RichMan
//
//  Created by JUMP on 2022/1/5.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var text = "333"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = text
    }


}

