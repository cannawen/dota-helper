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
        let ward = UIImage(named: "observer_ward")!
        let touchPoint = sender.location(in: mapImageView)
        let wardImageView = UIImageView(image: ward)
        wardImageView.center = touchPoint
        mapImageView.addSubview(wardImageView)
    }
}

