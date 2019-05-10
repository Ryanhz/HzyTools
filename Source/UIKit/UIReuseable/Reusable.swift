//
//  Reusable.swift
//  hzy
//
//  Created by hzy on 2018/1/22.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit

public protocol HzyReusable: HzyNameOfClassable {}

public protocol HzyNibReusable: HzyReusable {}

extension HzyReusable {
    public static var defaultIdentifier: String { return nameOfClass + ".fe." + "identifier" }
    public var defaultIdentifier: String { return Self.defaultIdentifier }
}

extension HzyNibReusable {
    public static var nib: UINib {
        return UINib(nibName: nameOfClass, bundle: nil)
    }
}

extension UITableViewCell: HzyNibReusable {}
extension UICollectionReusableView: HzyNibReusable {}
extension UITableViewHeaderFooterView: HzyNibReusable {}

