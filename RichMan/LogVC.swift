//
//  LogVC.swift
//  RichMan
//
//  Created by JUMP on 2022/1/20.
//

import UIKit

class LogVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var teamKey = TeamKey.chick
    var logAry = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        teamImageView.image = UIImage(named: teamKey.rawValue)
        
        tableView.registerCell([.logCell])
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LogCell = tableView.createCell(indexPath: indexPath)
        cell.label.text = "\(indexPath.row+1). \(logAry[indexPath.row])"
        return cell
    }
    
}
