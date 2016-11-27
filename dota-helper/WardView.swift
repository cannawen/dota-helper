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
    @IBOutlet weak var wardImageView: UIImageView!
    
    static func new(ward: Ward, currentTime: TimeInterval) -> WardView {
        let wardView = Bundle.main.loadNibNamed("WardView", owner: self, options: nil)![0] as! WardView
        return wardView.setup(ward: ward, currentTime: currentTime);
    }
    
    private func setup(ward: Ward, currentTime: TimeInterval) -> WardView {
        func timeRemainingString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "m:ss"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let timeRemaining = Date(timeIntervalSince1970: ward.timeRemaining(currentTime: currentTime))
            return dateFormatter.string(from: timeRemaining)
        }
        
        center = ward.location
        wardImageView.image = ward.type.image()
        countdownLabel.text = timeRemainingString()
        
        return self
    }
}

private extension Ward {
    func timeRemaining(currentTime: TimeInterval) -> TimeInterval {
        let age = currentTime - creationTime
        return type.lifespan() - age
    }
}

private extension WardType {
    func image() -> UIImage {
        switch self {
        case .observer:
            return UIImage(named: .observerWard)
        case .demo:
            return UIImage(named: .observerWard)
        case .sentry:
            return UIImage(named: .sentryWard)
        }
    }
}
