//
//  WardView.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import UIKit

protocol WardViewDelegate {
    func wardExpired(wardView: WardView)
}

class WardView: UIView {

    @IBOutlet weak var countdownLabel: UILabel!
    
    var secondsRemaining : TimeInterval = 6 * 60
    var timer : Timer!
    var dateFormatter = DateFormatter()
    var delegate : WardViewDelegate!
    
    static func newFromNib(delegate: WardViewDelegate, type: WardType) -> WardView {
        let wardView = Bundle.main.loadNibNamed("WardView", owner: self, options: nil)![0] as! WardView
        wardView.setup(delegate: delegate)
        return wardView
    }
    
    func setup(delegate: WardViewDelegate) {
        self.delegate = delegate
        self.dateFormatter.dateFormat = "m:ss"
        self.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        secondsRemaining -= 1;
        if secondsRemaining < 0 {
            delegate.wardExpired(wardView: self)
        } else {
            countdownLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: secondsRemaining))
        }
    }
    
}
