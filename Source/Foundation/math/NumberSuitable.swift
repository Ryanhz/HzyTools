//
//  HzySuitSizeable.swift
//  hzy
//
//  Created by hzy on 2018/2/8.
//  Copyright © 2018年 hzy. All rights reserved.
//

import Foundation
import UIKit

public protocol NumberSuitable {}

extension Int: NumberSuitable  {
    public var float: Float { return Float(self) }
    public var double: Double { return Double(self) }
    public var cgFloat: CGFloat { return CGFloat(self) }
}

extension Double: NumberSuitable  {
    public var int: Int { return Int(self) }
    public var float: Float { return Float(self) }
    public var cgFloat: CGFloat { return CGFloat(self) }
}

extension Float: NumberSuitable  {
    public var cgFloat: CGFloat {return CGFloat(self) }
    public var int: Int { return Int(self) }
    public var double: Double { return Double(self)}
}

extension CGFloat: NumberSuitable {
    public var int: Int { return Int(self)}
    public var float: Float { return Float(self) }
    public var double: Double { return Double(self) }
}

extension Int: HzyNamespaceWrappable {}

extension Float: HzyNamespaceWrappable{}

extension Double: HzyNamespaceWrappable{}

extension CGFloat: HzyNamespaceWrappable{}

extension HzyNamespaceWrapper where T == Int {
    public var float: Float { return wrappedValue.float }
    public var double: Double { return wrappedValue.double }
    public var cgFloat: CGFloat { return wrappedValue.cgFloat }
}

extension HzyNamespaceWrapper where T == Float {
    public var int: Int { return wrappedValue.int }
    public var double: Double { return wrappedValue.double }
    public var cgFloat: CGFloat { return wrappedValue.cgFloat }
}

extension HzyNamespaceWrapper where T == Double {
    public var int: Int { return wrappedValue.int }
    public var float: Float { return wrappedValue.float }
    public var cgFloat: CGFloat { return wrappedValue.cgFloat }
}

extension HzyNamespaceWrapper where T == CGFloat {
    public var int: Int { return wrappedValue.int }
    public var float: Float { return wrappedValue.float }
    public var double: Double { return wrappedValue.double }
}
