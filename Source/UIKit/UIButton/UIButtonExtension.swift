//
//  UIButtonExtension.swift
//  hzy
//
//  Created by hzy on 2018/1/23.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit

extension UIButton {
    struct HzyAssociatedKeys {
        static var defaultInterval: TimeInterval = 0
        static var ignoreInterval: UInt8 = 0
        static var swapMethodKey_delayClick = "com.UIButtonswapMethod.delayClick.hzy"
    }
}

// MARK: -防止连续点击
extension UIButton {
    public var ignoreInterval: TimeInterval {
        get {
            return hzy.associatedObject(key: &HzyAssociatedKeys.ignoreInterval) {
                return HzyAssociatedKeys.defaultInterval
            }
        }
        set {
            hzy.associateSetObject(key: &HzyAssociatedKeys.ignoreInterval, value: newValue)
            
            guard newValue > 0 else {
                return
            }
            UIButton.swapMethod()
        }
    }
    
    @objc private dynamic func hzySendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if ignoreInterval > 0 {
            isUserInteractionEnabled = false
            DispatchQueue.main.hzy.after(ignoreInterval, execute: { [weak self] in
                self?.isUserInteractionEnabled = true
            })
        }
        hzySendAction(action, to: target, for: event)
    }
    
    class func swapMethod(){
        DispatchQueue.hzy.once(token: HzyAssociatedKeys.swapMethodKey_delayClick) {
            let systemSel = #selector(UIButton.sendAction(_:to:for:))
            let swizzSel = #selector(UIButton.hzySendAction(_:to:for:))
            
            let systemMethod = class_getInstanceMethod(self, systemSel)
            
            let swizzMethod = class_getInstanceMethod(self, swizzSel)
            
            let isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod!), method_getTypeEncoding(swizzMethod!))
            
            if isAdd {
                class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod!), method_getTypeEncoding(systemMethod!));
            }else {
                method_exchangeImplementations(systemMethod!, swizzMethod!);
            }
        }
    }
}

