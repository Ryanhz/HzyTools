//
//  DispatchQueueExtension.swift
//  hzy
//
//  Created by hzy on 2017/11/1.
//  Copyright © 2017年 hzy. All rights reserved.
//

import UIKit

extension DispatchQueue {
   static fileprivate var __onceTracker = [String]()
}

extension HzyNamespaceWrapper where T: DispatchQueue {
    
    public static var `default`: DispatchQueue { return DispatchQueue.global(qos: .`default`) }
    public static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    public static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    public static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    public static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }
    
    
    public func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        wrappedValue.asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    /// 本代码只能执行一次
    ///
    /// - Parameters:
    ///   - token: 本次的唯一标识__onceTracker
    ///   - block: 执行代码块
    public static func once(token: String, block: ()->Void) {
        objc_sync_enter(self)
        //Swift2.0中加入了defer新语法声明。defer译为延缓、推迟之意.主要到defer的用法，这条语句并不会马上执行，而是被推入栈中，直到函数结束时才再次被调用。
        
        defer {
            objc_sync_exit(self)
        }
        guard !DispatchQueue.__onceTracker.contains(token) else {
            return
        }
        
        DispatchQueue.__onceTracker.append(token)
        block()
    }
}

