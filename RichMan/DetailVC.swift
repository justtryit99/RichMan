//
//  DetailVC.swift
//  RichMan
//
//  Created by 莊文博 on 2022/1/6.
//

import UIKit

class DetailVC: UIViewController {

    var text = ""
    
    @IBOutlet weak var label: UILabel!
    
    
    deinit {
        print("\(String(describing: self)) deinit!!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = text
    }

    @IBAction func clickButton(_ sender: Any) {
        let popupVC: PopVC = MainSB.with(id: .popVC)
        present(popupVC, animated: true, completion: nil)
    }
    

}
