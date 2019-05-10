//
//  associatedExtension.swift
//  hzy
//
//  Created by hzy on 2017/11/8.
//  Copyright © 2017年 hzy. All rights reserved.
//

import Foundation

public protocol hzyAssociatedable {}

extension NSObject: hzyAssociatedable{}

extension hzyAssociatedable where Self: NSObject{
    
    public func associatedObject<ValueType: Any>(key: UnsafePointer<UInt8>, _ initialiser: ()-> ValueType) -> ValueType {
        if let associated = objc_getAssociatedObject(self, key) as? ValueType {
            return associated
        }
        
        let associated = initialiser()
        objc_setAssociatedObject(self, key, associated, .OBJC_ASSOCIATION_RETAIN)
        return associated
    }
    
    public func associatedObject<ValueType: Any>(key: UnsafePointer<UInt8>) -> ValueType? {
        let associated = objc_getAssociatedObject(self, key) as? ValueType
        return associated
    }
    
    public func associateSetObject<ValueType: Any>(key: UnsafePointer<UInt8>, value: ValueType?) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func associateSetUnownedObject<ValueType: Any>(key: UnsafePointer<UInt8>, value: ValueType?) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_ASSIGN)
    }
}

//TODO: ---Compiler bug
extension HzyNamespaceWrapper where T: NSObject {
    
    public func associatedObject<ValueType: Any>(key: UnsafePointer<UInt8>, _ initialiser: ()-> ValueType) -> ValueType {
        return wrappedValue.associatedObject(key: key, initialiser)
    }
    
    public func associatedObject<ValueType: Any>(key: UnsafePointer<UInt8>) -> ValueType? {
        return wrappedValue.associatedObject(key: key)
    }
    
    public func associateSetObject<ValueType: Any>(key: UnsafePointer<UInt8>, value: ValueType?) {
        wrappedValue.associateSetObject(key: key, value: value)
    }
}



