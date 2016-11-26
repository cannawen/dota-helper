//
//  GameState.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import Foundation

class GameState {
    private var wards : Array<Ward>
    private var currentTime : TimeInterval
    
    public init() {
        wards = []
        currentTime = 0
    }
    
    public func addWard(type: WardType) {
        wards.append(Ward(type: type, creationTime: currentTime))
    }
    
    public func incrementGameState() {
        func removeExpiredWards() {
            wards = wards.filter { $0.isValid(currentTime: currentTime) }
        }
        
        currentTime = currentTime + 1
        removeExpiredWards()
    }
}

private extension Ward {
    func isValid(currentTime: TimeInterval) -> Bool {
        let age = currentTime - creationTime
        return age <= type.lifespan();
    }
}
