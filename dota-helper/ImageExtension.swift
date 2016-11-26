//
//  ImageExtension.swift
//  dota-helper
//
//  Created by Canna Wen on 2016-11-26.
//  Copyright © 2016 Canna Wen. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init(named name: ImageName) {
        self.init(named: name.rawValue)!
    }
}
