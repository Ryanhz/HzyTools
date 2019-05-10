//
//  FENamespaceWrappable.swift
//  hzy
//
//  Created by hzy on 2017/11/1.
//  Copyright © 2017年 hzy. All rights reserved.
//

import UIKit

public protocol HzyNamespaceWrappable {
    associatedtype WrapperType
    var hzy: WrapperType { get }
    static var hzy: WrapperType.Type { get }
}

public class HzyNamespaceWrapper<T>{
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

public extension HzyNamespaceWrappable {
    var hzy: HzyNamespaceWrapper<Self> {
        return HzyNamespaceWrapper(value: self)
    }
    static var hzy: HzyNamespaceWrapper<Self>.Type {
        return HzyNamespaceWrapper.self
    }
}

extension NSObject: HzyNamespaceWrappable{}



