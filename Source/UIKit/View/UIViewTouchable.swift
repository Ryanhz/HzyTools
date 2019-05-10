//
//  UIViewTouchable.swift
//  hzy
//
//  Created by hzy on 2018/1/18.
//  Copyright © 2018年 hzy. All rights reserved.
//

//import Foundation
import UIKit

private var isTouchableKey: UInt8 = 0
private var touchBlockKey: UInt8 = 0
private var tapGestureRecognizerKey: UInt8 = 0

@objc protocol Touchable {
    @objc func hzyTouchAction()
}

extension UIView: Touchable {
    @objc func hzyTouchAction() {
        self.hzy.touchBlock?()
    }
}

extension HzyNamespaceWrapper where T: UIView {
    
    fileprivate var tapGestureRecognizer: UITapGestureRecognizer {
        get {
            return associatedObject(key: &tapGestureRecognizerKey, {
                let tap =  UITapGestureRecognizer()
                tap.addTarget(wrappedValue, action: #selector(wrappedValue.hzyTouchAction))
                return tap
            })
        }
    }
    
    fileprivate var isTouchable: Bool {
        get {
            return associatedObject(key: &isTouchableKey, {return false})
        }
        set {
            associateSetObject(key: &isTouchableKey, value: newValue)
        }
    }
    
    public var touchBlock: (()->Void)? {
        get {
            return associatedObject(key: &touchBlockKey)
        }
        set {
            if newValue != nil {
                isTouchable = wrappedValue.isUserInteractionEnabled
                wrappedValue.isUserInteractionEnabled = true
                wrappedValue.addGestureRecognizer(tapGestureRecognizer)
            } else {
                wrappedValue.isUserInteractionEnabled = isTouchable
                wrappedValue.removeGestureRecognizer(tapGestureRecognizer)
            }
            associateSetObject(key: &touchBlockKey, value: newValue)
        }
    }
    
    public func click(_ block: (()->Void)?){
        touchBlock = block
    }
}
