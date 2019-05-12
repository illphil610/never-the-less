//
//  UIImageView+Extensions.swift
//  never-the-less
//
//  Created by Philip on 5/11/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
