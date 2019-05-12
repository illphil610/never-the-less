//
//  UILabel+Extensions.swift
//  never-the-less
//
//  Created by Philip on 5/11/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}
