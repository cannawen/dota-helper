//
//  GameState.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import UIKit

class GameState {
    private(set) public var wards : Array<Ward>
    private(set) public var currentTime : TimeInterval
    
    public init() {
        wards = []
        currentTime = 0
    }
    
    public func addWard(type: WardType, location: CGPoint) {
        wards.append(Ward(type: type, creationTime: currentTime, location: location))
    }
    
    public func advanceTime() {
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
