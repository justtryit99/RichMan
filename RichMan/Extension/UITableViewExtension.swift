//
//  UITableViewExtension.swift
//  Comp
//
//  Created by 莊文博 on 2019/7/17.
//  Copyright © 2019 Addcn Technology Co., Ltd. All rights reserved.
//
import UIKit
import Foundation

extension UITableView {
    
    func registerCell(_ typeData: [XibType]) {
        
        for xibName in typeData {
            let nibCell = UINib(nibName: xibName.rawValue, bundle: nil)
            self.register(nibCell, forCellReuseIdentifier: xibName.rawValue)
        }
    }
    
    func registerView(_ typeData: [XibType]) {
        
        for xibName in typeData {
            let nib = UINib(nibName: xibName.rawValue, bundle: nil)
            self.register(nib, forHeaderFooterViewReuseIdentifier: xibName.rawValue)
        }
    }
    
    func createCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("遺失 \(String(describing: T.self)) 註冊檔")
        }
        return cell
    }
    
    func createView<T: UITableViewHeaderFooterView>() -> T {
        
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("遺失 \(String(describing: T.self)) 註冊檔")
        }
        return view
    }
    
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    func scroll(to: ScrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(0)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            
            switch to {
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            }
        }
    }
    
    enum ScrollsTo {
        case top, bottom
    }
    
    func reloadDataSmoothly() {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { () -> Void in
            UIView.setAnimationsEnabled(true)
        }
        
        reloadData()
        beginUpdates()
        endUpdates()
        
        CATransaction.commit()
    }
}
