//
//  GameState.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import UIKit

protocol GameRenderer {
    func render(gameState: GameState)
}

class GameState {
    private(set) public var wards: Array<Ward>!
    private(set) public var currentTime: TimeInterval!
    private(set) public var paused: Bool!

    private var timer: Timer?
    private var renderer: GameRenderer!
    
    public func resetGame(renderer: GameRenderer) {
        wards = []
        currentTime = 0
        paused = false
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        }
        
        self.renderer = renderer
        renderer.render(gameState: self)
    }
    
    public func addWard(type: WardType, location: CGPoint) {
        wards.append(Ward(type: type, creationTime: currentTime, location: location))
        renderer.render(gameState: self)
    }
    
    public func togglePauseState() {
        paused = !paused
        renderer.render(gameState: self)
    }
    
    @objc private func tick() {
        guard !paused else {
            return
        }
        
        func removeExpiredWards() {
            wards = wards.filter { $0.isValid(currentTime: currentTime) }
        }
        
        currentTime = currentTime + 1
        removeExpiredWards()
        renderer.render(gameState: self)
    }
}

private extension Ward {
    func isValid(currentTime: TimeInterval) -> Bool {
        let age = currentTime - creationTime
        return age <= type.lifespan();
    }
}
