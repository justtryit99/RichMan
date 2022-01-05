//
//  BaseTableViewCell.swift
//  Parttime
//
//  Created by 莊文博 on 2020/4/20.
//  Copyright © 2020 Addcn. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
