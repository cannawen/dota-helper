//
//  MapViewController.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapImageView: UIImageView!
    
    @IBAction func mapTapped(_ sender: UITapGestureRecognizer) {
        let wardView = WardView.loadFromNib(delegate: self)
        let touchPoint = sender.location(in: mapImageView)
        wardView.center = touchPoint
        mapImageView.addSubview(wardView)
    }
}

extension MapViewController: WardViewDelegate {
    func wardExpired(wardView: WardView) {
        wardView.removeFromSuperview()
    }
}
