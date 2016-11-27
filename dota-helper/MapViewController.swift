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
    @IBOutlet weak var resetButton: UIButton!
    
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
    
    @IBAction func pauseToggleTapped() {
        gameState.togglePauseState()
    }
    
    @IBAction func resetButtonTapped() {
        gameState.reset()
    }
}

extension MapViewController: GameRenderer {
    func render(gameState: GameState) {
        mapImageView.render(gameState: gameState)
        togglePauseButton.renderPauseButton(gameState: gameState)
        resetButton.renderResetButton()
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
    func renderPauseButton(gameState: GameState) {
        titleLabel?.numberOfLines = 0
        setTitle(gameState.pauseButtonTitle(), for: .normal)
        backgroundColor = gameState.pauseButtonColor()
    }
    
    func renderResetButton() {
        titleLabel?.numberOfLines = 0
        setTitle("RESET".addEndlines(), for: .normal)
    }
}

private extension GameState {
    func pauseButtonTitle() -> String {
        if paused {
            return "RESUME".addEndlines()
        } else {
            return "PAUSE".addEndlines()
        }
    }
    
    func pauseButtonColor() -> UIColor {
        if paused {
            return .green
        } else {
            return .red
        }
    }
}

private extension String {
    func addEndlines() -> String {
        let stringArray = self.characters.map { String($0) }
        return stringArray.joined(separator: "\n")
    }
}
