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
    
    var secondsRemaining = 6 * 60;
    var timer : Timer!;
    
    static func loadFromNib() -> WardView {
        return Bundle.main.loadNibNamed("WardView", owner: self, options: nil)![0] as! WardView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        secondsRemaining -= 1;
        let seconds = secondsRemaining % 60;
        let minutes = secondsRemaining / 60;
        countdownLabel.text = "\(minutes):\(seconds)"
    }

}
