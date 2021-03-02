//
//  UIFont+Extension.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 28/02/2021.
//

import UIKit

extension UIFont {
    static func of(type: String, size: CGFloat) -> UIFont? {
        return UIFont(name: type, size: size)
    }
}
