//
//  RootTBVC.swift
//  RichMan
//
//  Created by JUMP on 2022/1/5.
//

import UIKit
//import LTMorphingLabel

class RootTBVC: UITableViewController {
    
//    let model = RootTBModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.setBackgroundColor(.clear)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if tableView.tableHeaderView == nil {
            tableView.tableHeaderView = RootHeader(frame: CGRect(x: 0, y: 0, width: view.width, height: 80))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareData.setData()
        
        
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.registerCell([.teamCell])
        
        //print("preferredDisplayMode: \(splitViewController?.preferredDisplayMode.rawValue)")
        
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shareData.dataAry.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let cellData = shareData.dataAry[row]
        let cell: TeamCell = tableView.createCell(indexPath: indexPath)
        cell.backgroundColor = cellData.color
        cell.headImageView.image = UIImage(named: cellData.key.rawValue)
        cell.scoreLabel.text = "\(cellData.score)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let cellData = shareData.dataAry[row]
        
        let vc = DetailVC()
        vc.delegate = self
        vc.teamKey = cellData.key
        // 加了nac，sb的detailVC就會消失，不會一直push下去
        let nav = UINavigationController(rootViewController: vc)
//        vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        splitViewController?.showDetailViewController(nav, sender: nil)
        
    }

    
}

// MARK: - DetailVCDelegate
extension RootTBVC: DetailVCDelegate {
    func detatilSendReload() {
        
        // 記錄原始排名
        var oldIndexAry = [TeamKey]()
        for (_, cellData) in shareData.dataAry.enumerated() {
            oldIndexAry.append(cellData.key)
        }
        
        for (index, cellData) in shareData.dataAry.enumerated() {
            
            let newScore = cellData.score
            
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TeamCell {
                let result = "\(newScore)".compare(cell.scoreLabel.text.str, options: .numeric)
                if result == .orderedDescending {
                    // Descending 降序, 新 大於 舊
                    cell.scoreLabel.morphingEffect = .evaporate
                } else {
                    // 升序或相等, 新 小於 舊
                    cell.scoreLabel.morphingEffect = .fall
                }
                cell.scoreLabel.text = "\(newScore)"
                print("newScore: \(newScore), key: \(shareData.dataAry[index].key)")
            }
        }
        
        shareData.dataAry.sort { data1, data2 in
            return data1.score > data2.score
        }
        dump(shareData.dataAry)
        
        DispatchQueue.main.asyncAfter(deadline: 0.8) {
            for (newIndex, data) in shareData.dataAry.enumerated() {
                if let oldIndex = oldIndexAry.firstIndex(where: { $0 == data.key }) {
//                    print("old: \(oldIndex) \(oldIndexAry[oldIndex]), new: \(newIndex) \(data.key)")
                    self.tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
                    oldIndexAry.remove(at: oldIndex)
                    oldIndexAry.insert(shareData.dataAry[newIndex].key, at: newIndex)
//                    print("oldIndexAry: \(oldIndexAry)")
                }
            }
        }
        print("oldIndexAry: \(oldIndexAry)")
    }
}


extension Optional {
    var str: String {
        return ((self as? String) != nil) ? self as! String : ""
    }
}
