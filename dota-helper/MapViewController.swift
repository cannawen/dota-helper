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
    @IBOutlet weak var togglePauseButton: UIButton!
    
    let gameState = GameState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleTapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        gameState.startGame(renderer: self)
    }
    
    @IBAction func mapTapped(_ sender: UITapGestureRecognizer) {
        gameState.addWard(type: .observer, location: sender.location(in: mapImageView))
    }
    
    @IBAction func mapDoubleTapped(_ sender: UITapGestureRecognizer) {
        gameState.addWard(type: .sentry, location: sender.location(in: mapImageView))
    }
    
    @IBAction func togglePauseState() {
        gameState.togglePauseState()
    }
}

extension MapViewController: GameRenderer {
    func render(gameState: GameState) {
        mapImageView.render(gameState: gameState)
        togglePauseButton.render(gameState: gameState)
    }
}

private extension UIImageView {
    func render(gameState: GameState) {
        subviews.forEach { $0.removeFromSuperview() }
        let wardViews = gameState.wards.map { WardView.new(ward: $0, currentTime: gameState.currentTime) }
        wardViews.forEach { addSubview($0) }
    }
}

private extension UIButton {
    func render(gameState: GameState) {
        setTitle(gameState.pauseState.buttonTitle(), for: .normal)
        backgroundColor = gameState.pauseState.buttonColor()
    }
}

private extension PauseState {
    func buttonTitle() -> String {
        switch self {
        case .paused:
            return "Resume"
        case .inProgress:
            return "Pause"
        }
    }
    
    func buttonColor() -> UIColor {
        switch self {
        case .paused:
            return .green
        case .inProgress:
            return .red
        }
    }
}
