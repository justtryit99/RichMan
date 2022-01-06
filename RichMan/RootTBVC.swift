//
//  RootTBVC.swift
//  RichMan
//
//  Created by JUMP on 2022/1/5.
//

import UIKit

class RootTBVC: UITableViewController {
    
    let model = RootTBModel()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if tableView.tableHeaderView == nil {
            tableView.tableHeaderView = RootHeader(frame: CGRect(x: 0, y: 0, width: view.width, height: 80))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.setData()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.registerCell([.teamCell])
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        let cellData = model.data[row]
        
        let vc = DetailVC()
//        navigationController?.pushViewController(vc, animated: true)
        
//        splitViewController?.pushViewController(vc, animated: true)
        
//        if let splitVC = self.splitViewController, let detailVC = splitVC.viewControllers[1] as? ViewController {
//            detailVC.label.text = cellData.key.rawValue
//        }
//        print("viewControllers: \(splitViewController?.viewControllers[1])")
//
//        if let nav = splitViewController?.viewControllers[1] as? UINavigationController {
//            print("nav viewControllers: \(nav.viewControllers)")
//
//            if let vc = nav.viewControllers[0] as? ViewController {
//                vc.label.text = cellData.key.rawValue
//            }
//        }
        
        
        vc.text = cellData.key.rawValue
        splitViewController?.showDetailViewController(vc, sender: nil)
        
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
