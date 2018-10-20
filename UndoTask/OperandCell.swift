//
//  OperandCell.swift
//  UndoTask
//
//  Created by Sherif Nasr on 10/20/18.
//  Copyright © 2018 Sherif Nasr. All rights reserved.
//

import UIKit

class OperandCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 4
    }
}
