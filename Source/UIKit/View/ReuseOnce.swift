//
//  ReuseOnce.swift
//  hzy
//
//  Created by hzy on 2018/1/26.
//  Copyright © 2018年 hzy. All rights reserved.
//

import Foundation
import UIKit

private var isConfigKey: UInt8 = 0

extension HzyNamespaceWrapper where T: UIView {
    
   private(set) var isConfig: Bool {
        get {
            return associatedObject(key: &isConfigKey, {return false})
        }
        set {
            associateSetObject(key: &isConfigKey, value: newValue)
        }
    }
    
    public func onceConfig(block: ((T)->Void)?) {
        guard let block = block, isConfig == false else {
            return
        }
        isConfig = true
        block(wrappedValue)
    }
}

