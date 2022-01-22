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
    
    lazy var sourceItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        let button = UIButton(type: .detailDisclosure)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.addTarget(self, action: #selector(clickSourceItem(_:)), for: .touchUpInside)
        item.customView = button
        return item
    }()
    
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
        navigationItem.leftBarButtonItem = sourceItem
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.registerCell([.teamCell])
        
        //print("preferredDisplayMode: \(splitViewController?.preferredDisplayMode.rawValue)")
        
        
        // *** 正式開始記得打開 ***
//        if let _ = Defaults[.dataAry] {
//            // 是否讀取舊資料
//            showAlert(title: "是否讀取舊資料") { action in
//                // 如果讀取存檔資料，應該是正式資料
//                sourceType = .formal
//                getDefaults()
//                self.tableView.reloadData()
//            }
//        }
        
        
        // 測試用
        sourceType = .formal
        testSource()
        
    }
    
    @objc func clickSourceItem(_ sender: UIButton) {
        let testAction = UIAlertAction(title: "測試", style: .default) { action in
            showAlert(title: "切『 測試 』資料") { _ in
                sourceType = .test
                self.tableView.reloadData()
                Defaults.removeAll()
            }
        }
        let formalAction = UIAlertAction(title: "正式", style: .default) { action in
            showAlert(title: "切『 正式 』資料") { _ in
                sourceType = .formal
                self.tableView.reloadData()
                Defaults.removeAll()
            }
        }
        UIAlertController.show(title: "Source", style: .actionSheet,
                               actions: [testAction, formalAction],
                               sourceView: sender)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shareData.dataAry.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        let cellData = shareData.dataAry[row]
        let cell: TeamCell = tableView.createCell(indexPath: indexPath)
        cell.backgroundColor = cellData.key.toColor()
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

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let row = indexPath.row
        let cellData = shareData.dataAry[row]
        
        let editAction = UIContextualAction(style: .normal, title: "修改") { (action, view, completionHandler) in
            
            let alert = UIAlertController(title: "修改積分", message: nil, preferredStyle: .alert)
            
            alert.addTextField { textField in
                textField.keyboardType = .numberPad
            }
            
            let okAction = UIAlertAction(title: "修改", style: .default) { action in
                let text = alert.textFields?.first?.text ?? ""
                if let score = Int(text) {
                    
                } else {
                    showAlert(title: "不是數字", confirmHandle: nil)
                }
            }
            
            alert.addAction(okAction)
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor(255, 171, 69, 1)
        
        let logAction = UIContextualAction(style: .normal, title: "Log") { (action, view, completionHandler) in
            let vc = LogVC()
            vc.teamKey = cellData.key
            vc.logAry = cellData.log
            // 加了nac，sb的detailVC就會消失，不會一直push下去
            let nav = UINavigationController(rootViewController: vc)
            self.splitViewController?.showDetailViewController(nav, sender: nil)
            completionHandler(true)
        }
        logAction.backgroundColor = .lightRed
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction, logAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
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
        //dump(shareData.dataAry)
        
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
        //print("oldIndexAry: \(oldIndexAry)")
        
        saveToDefaults()
        
    }
    
}


extension Optional {
    var str: String {
        return ((self as? String) != nil) ? self as! String : ""
    }
}
