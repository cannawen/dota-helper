//
//  WardView.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import UIKit

class WardView: UIView {

    @IBOutlet weak var countdownLabel: UILabel!
    
    static func loadFromNib() -> WardView {
        return Bundle.main.loadNibNamed("WardView", owner: self, options: nil)![0] as! WardView
    }

}
