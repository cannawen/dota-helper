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
    @IBOutlet var singleTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var doubleTapGestureRecognizer: UITapGestureRecognizer!
    
    let gameState = GameState()
    var timer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGameState), userInfo: nil, repeats: true)
    }
    
    func updateGameState() {
        gameState.advanceTime()
        redrawGameState()
    }
    
    @IBAction func mapTapped(_ sender: UITapGestureRecognizer) {
        gameState.addWard(type: .observer, location: sender.location(in: mapImageView))
        redrawGameState()
    }
    
    @IBAction func mapDoubleTapped(_ sender: UITapGestureRecognizer) {
        gameState.addWard(type: .sentry, location: sender.location(in: mapImageView))
        redrawGameState()
    }
    
    private func redrawGameState() {
        mapImageView.subviews.forEach { $0.removeFromSuperview() }
        let wardViews = gameState.wards.map { WardView.new(ward: $0, currentTime: gameState.currentTime) }
        wardViews.forEach { mapImageView.addSubview($0) }
    }
}
