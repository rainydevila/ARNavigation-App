//
//  RootViewCell.swift
//  BluePlane
//
//  Created by 原田龍青 on 2019/12/25.
//  Copyright © 2019 原田龍青. All rights reserved.
//

import UIKit

class RootViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func showSample(_ sample: Sample) {
        titleLabel.text  = sample.title
    }
}
