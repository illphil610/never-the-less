//
//  UIButton+Extensions.swift
//  never-the-less
//
//  Created by Philip on 5/11/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        setTitle(title, for: .normal)
    }
}

