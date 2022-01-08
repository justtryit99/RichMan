//
//  TestVC.swift
//  RichMan
//
//  Created by JUMP on 2022/1/8.
//

import UIKit

class TestVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "\(text)"
        img.image = UIImage(named: text)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
