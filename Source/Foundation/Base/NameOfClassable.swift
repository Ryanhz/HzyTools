//
//  NameOfClassable.swift
//  hzy
//
//  Created by hzy on 2017/12/7.
//  Copyright © 2017年 hzy. All rights reserved.
//

import Foundation

public protocol HzyNameOfClassable {
    static var nameOfClass: String {get}
    var nameOfClass: String {get}
}

extension HzyNameOfClassable {
    /*
     let classString = NSStringFromClass(self)
     return classString.components(separatedBy: ".").last ?? classString
    */
    public static var nameOfClass: String { return String(describing: self) }
    public var nameOfClass: String { return Self.nameOfClass }
}

extension NSObject: HzyNameOfClassable {}

