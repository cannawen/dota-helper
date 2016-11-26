//
//  Ward.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import Foundation

class Ward {
    var type : WardType
    var creationTime : TimeInterval
    
    init(type wardType: WardType, creationTime time: TimeInterval) {
        type = wardType
        creationTime = time
    }
}

extension Ward: Hashable {
    var hashValue: Int {
        return type.hashValue ^ creationTime.hashValue
    }
    
    static func == (lhs: Ward, rhs: Ward) -> Bool {
        return lhs.type == rhs.type && lhs.creationTime == rhs.creationTime
    }
}
