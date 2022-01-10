//
//  RootTBVC.swift
//  RichMan
//
//  Created by JUMP on 2022/1/5.
//

import UIKit
//import LTMorphingLabel

class RootTBVC: UITableViewController {
    
    let model = RootTBModel()
    
    
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
        model.setData()
        
        let barAppearance =  UINavigationBarAppearance()
        barAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.registerCell([.teamCell])
        
        print("preferredDisplayMode: \(splitViewController?.preferredDisplayMode.rawValue)")
        
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cellData = model.data[row]
        let cell: TeamCell = tableView.createCell(indexPath: indexPath)
        cell.backgroundColor = cellData.color
        cell.headImageView.image = UIImage(named: cellData.key.rawValue)
        cell.scoreLabel.text = "\(cellData.score)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let cellData = model.data[row]
        
        let vc = DetailVC()

        vc.text = cellData.key.rawValue
        // 加了nac，sb的detailVC就會消失，不會一直push下去
        let nav = UINavigationController(rootViewController: vc)
//        vc.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        splitViewController?.showDetailViewController(nav, sender: nil)
        
        // 記錄原始排名
        var oldIndexAry = [TeamKey]()
        for (_, cellData) in model.data.enumerated() {
            oldIndexAry.append(cellData.key)
        }
        print("first oldIndexAry: \(oldIndexAry)")
        
        for (index, _) in model.data.enumerated() {
            let ranInt = Int.random(in: 1000...2000)
            model.data[index].score = ranInt
            
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? TeamCell {
                let result = "\(ranInt)".compare(cell.scoreLabel.text.str, options: .numeric)
                if result == .orderedDescending {
                    // Descending 降序, 新 大於 舊
                    cell.scoreLabel.morphingEffect = .evaporate
                } else {
                    // 升序或相等, 新 小於 舊
                    cell.scoreLabel.morphingEffect = .fall
                }
                cell.scoreLabel.text = "\(ranInt)"
                print("ranInt: \(ranInt), key: \(model.data[index].key)")
            }
        }
        
        model.data.sort { data1, data2 in
            return data1.score > data2.score
        }
        dump(model.data)
        
        DispatchQueue.main.asyncAfter(deadline: 0.8) {
            for (newIndex, data) in self.model.data.enumerated() {
                if let oldIndex = oldIndexAry.firstIndex(where: { $0 == data.key }) {
//                    print("old: \(oldIndex) \(oldIndexAry[oldIndex]), new: \(newIndex) \(data.key)")
                    tableView.moveRow(at: IndexPath(row: oldIndex, section: 0), to: IndexPath(row: newIndex, section: 0))
                    oldIndexAry.remove(at: oldIndex)
                    oldIndexAry.insert(self.model.data[newIndex].key, at: newIndex)
//                    print("oldIndexAry: \(oldIndexAry)")
                }
            }
        }
        print("oldIndexAry: \(oldIndexAry)")
        
        
        
        
        // test
//        let vc = TestVC()
//        vc.text = cellData.key.rawValue
//        let nav = UINavigationController(rootViewController: vc)
//        splitViewController?.showDetailViewController(nav, sender: nil)
        
        
        
        
        
//        vc.navigationItem.leftItemsSupplementBackButton = true
//        self.splitViewController?.viewControllers[1] = vc
        
        if #available(iOS 14.5, *) {
//            splitViewController?.displayModeButtonVisibility = .always
        } else {
            // Fallback on earlier versions
        }
        
        
//        let vc: ViewController = MainSB.with(id: .VC)
//        vc.text = cellData.key.rawValue
//        splitViewController?.showDetailViewController(vc, sender: nil)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//
//                let controller = (segue.destination as! UINavigationController).topViewController as! ViewController
//                // 2.
//                controller.label.text = model.data[indexPath.row].key.rawValue
//                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//
//        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailNavigationViewController") as! UINavigationController
//        self.splitViewController?.viewControllers[1] = detailViewController
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}


extension Optional {
    var str: String {
        return ((self as? String) != nil) ? self as! String : ""
    }
}
