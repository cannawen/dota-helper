//
//  WardType.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import Foundation

enum WardType {
    case observer
    case sentry
    case demo
    
    func lifespan() -> TimeInterval {
        switch self {
        case .observer:
            return 6.minutes()
        case .sentry:
            return 4.minutes()
        case .demo:
            return 15
        }
    }
}

extension TimeInterval {
    func minutes() -> TimeInterval {
        return self * 60
    }
}
