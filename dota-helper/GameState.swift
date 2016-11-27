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
    private(set) public var wards: Array<Ward> = []
    private(set) public var currentTime: TimeInterval = 0
    private(set) public var paused: Bool = true

    private var timer: Timer!
    private var renderer: GameRenderer!
    
    public func startGame(renderer: GameRenderer) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        self.renderer = renderer
        reset()
    }
    
    public func reset() {
        wards = []
        currentTime = 0
        paused = false
        renderer.render(gameState: self)
    }
    
    public func addWard(type: WardType, location: CGPoint) {
        wards.append(Ward(type: type, creationTime: currentTime, location: location))
        renderer.render(gameState: self)
    }
    
    @objc public func tick() {
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
    
    public func togglePauseState() {
        paused = !paused
        renderer.render(gameState: self)
    }
}

private extension Ward {
    func isValid(currentTime: TimeInterval) -> Bool {
        let age = currentTime - creationTime
        return age <= type.lifespan();
    }
}
