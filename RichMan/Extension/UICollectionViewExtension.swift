//
//  UICollectionViewExtension.swift
//  Parttime
//
//  Created by 莊文博 on 2019/10/23.
//  Copyright © 2019 Addcn. All rights reserved.
//

import UIKit
import Foundation

extension UICollectionView {
    func registerCell(_ typeData: [XibType]) {
        
        for xibName in typeData {
            let nibCell = UINib(nibName: xibName.rawValue, bundle: nil)
            self.register(nibCell, forCellWithReuseIdentifier: xibName.rawValue)
        }
    }
    
    func registerView(_ typeData: [XibType]) {
        
        for xibName in typeData {
            let nib = UINib(nibName: xibName.rawValue, bundle: nil)
            self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: xibName.rawValue)
            self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: xibName.rawValue)
        }
    }
    
    func createCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            
            fatalError("遺失 \(String(describing: T.self)) 註冊檔")
        }
        
        return cell
    }
    
    func createHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        
        guard let view = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            
            fatalError("遺失 \(String(describing: T.self)) 註冊檔")
        }
        return view
    }
    
    func createFooterView<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        
        guard let view = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            
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
    
    func selectMoreItems(paths: [IndexPath], animated: Bool = false, position: UICollectionView.ScrollPosition = .left) {
        paths.forEach { 
            self.selectItem(at: $0, animated: animated, scrollPosition: position)
        }
    }
}
