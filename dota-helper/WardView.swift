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
    
    var secondsRemaining : TimeInterval = 6 * 60;
    var timer : Timer!;
    var dateFormatter = DateFormatter();
    
    static func loadFromNib() -> WardView {
        return Bundle.main.loadNibNamed("WardView", owner: self, options: nil)![0] as! WardView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "m:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        secondsRemaining -= 1;
        countdownLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: secondsRemaining))
    }

}
