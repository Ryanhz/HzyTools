//
//  HzySwipeEndEditingable.swift
//  hzy
//
//  Created by hzy on 2018/1/24.
//  Copyright © 2018年 hzy. All rights reserved.
//

import Foundation
import UIKit
public protocol HzySwipeEndEditingable: UIGestureRecognizerDelegate {}

private var HzyDownSwipeKey: UInt8 = 0
private var HzyUpSwipeKey: UInt8 = 0
private var HzyisEndEditingWhenSwipeKey: UInt8 = 0

extension UIResponder {
    @objc func hzySwipeAction(_ recognizer: UISwipeGestureRecognizer) {
        if let `self` = self as? UIViewController {
            self.view.endEditing(true)
            self.navigationController?.view.endEditing(true)
        }
        if let `self` = self as? UIView {
            self.endEditing(true)
        }
    }
}

extension HzyNamespaceWrapper where T: UIResponder, T: HzySwipeEndEditingable {
    var downSwipeGestureRecognizer : UISwipeGestureRecognizer {
        get {
            return associatedObject(key: &HzyDownSwipeKey, {
                let downSwipe = UISwipeGestureRecognizer(target: wrappedValue, action: #selector(UIResponder.hzySwipeAction(_:)))
                downSwipe.delegate = wrappedValue //as? UIGestureRecognizerDelegate
                downSwipe.direction = .down
                downSwipe.isEnabled = isEndEditingWhenSwipe
                if let view = wrappedValue as? UIView {
                    view.addGestureRecognizer(downSwipe)
                } else if let vc = wrappedValue as? UIViewController {
                    vc.view.addGestureRecognizer(downSwipe)
                }
                return downSwipe
            })
        }
    }
    
    var upSwipeGestureRecognizer : UISwipeGestureRecognizer {
        get {
            return associatedObject(key: &HzyUpSwipeKey, {
                let upSwipe = UISwipeGestureRecognizer(target: wrappedValue, action: #selector(UIResponder.hzySwipeAction(_:)))
                upSwipe.delegate = wrappedValue //as? UIGestureRecognizerDelegate
                upSwipe.direction = .up
                upSwipe.isEnabled = isEndEditingWhenSwipe
               
                if let view = wrappedValue as? UIView {
                   view.addGestureRecognizer(upSwipe)
                } else if let vc = wrappedValue as? UIViewController {
                    vc.view.addGestureRecognizer(upSwipe)
                }
                return upSwipe
            })
        }
    }
    
   public var isEndEditingWhenSwipe: Bool {
        set {
            guard isEndEditingWhenSwipe !=  newValue else {
                return
            }
            associateSetObject(key: &HzyisEndEditingWhenSwipeKey, value: newValue)
            downSwipeGestureRecognizer.isEnabled = newValue
            upSwipeGestureRecognizer.isEnabled = newValue
        }
        get {
            return associatedObject(key:  &HzyisEndEditingWhenSwipeKey, {return false})
        }
    }
}

