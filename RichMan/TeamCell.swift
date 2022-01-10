//
//  TeamCell.swift
//  RichMan
//
//  Created by JUMP on 2022/1/5.
//

import UIKit
import LTMorphingLabel

class TeamCell: BaseTableViewCell {
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var scoreLabel: LTMorphingLabel!
    @IBOutlet weak var circleView: CircleView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        scoreLabel.textColor = .white
        circleView.backgroundColor = .white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
