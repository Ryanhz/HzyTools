//
//  HzyDotable.swift
//  hzy
//
//  Created by hzy on 2018/2/7.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit

private  var HzyDotKey: UInt8 = 0

private enum HzyDotConstraintType: String {
    case top = "hzy.dot.Constraint.top"
    case right = "hzy.dot.Constraint.right"
    case width = "hzy.dot.Constraint.minWidth"
    case height = "hzy.dot.Constraint.height"
}

public protocol HzyDotable {}

extension HzyDotable where Self: UIView {
    
    var dotView: UIView {
        set {
            hzy.associateSetObject(key: &HzyDotKey, value: newValue)
        }
        get{
            let setConstraint: ( UIView ) ->Void = {[weak self] (dot) in
                guard let `self` = self else {
                    return
                }
                let widthConstraint = NSLayoutConstraint(item: dot, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 4)
                
                let heightConstraint = NSLayoutConstraint(item: dot, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 4)
                
                let topConstraint = NSLayoutConstraint(item: dot, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 1)
                
                let rightConstraint = NSLayoutConstraint(item: dot, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 1)
                
                widthConstraint.identifier = HzyDotConstraintType.width.rawValue
                heightConstraint.identifier = HzyDotConstraintType.height.rawValue
                topConstraint.identifier = HzyDotConstraintType.top.rawValue
                rightConstraint.identifier = HzyDotConstraintType.right.rawValue
                //添加多个约束
                dot.superview?.addConstraint(topConstraint)
                dot.superview?.addConstraint(rightConstraint)
                dot.addConstraint(widthConstraint)
                dot.addConstraint(heightConstraint)
            }
            
            return hzy.associatedObject(key: &HzyDotKey,{
                let dot = UIView()
                dot.backgroundColor = UIColor.red
                dot.layer.cornerRadius = 2
                dot.layer.masksToBounds = true
                dot.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(dot)
                setConstraint(dot)
                return dot
            })
        }
    }
    
    public var dotColor: UIColor? {
        get {
            return dotView.backgroundColor
        }
        set {
            dotView.backgroundColor = newValue
        }
    }
    
    public var dotRight: CGFloat {
        set {
            dotView.superview?.constraints.filter({return $0.identifier == HzyDotConstraintType.right.rawValue}).first?.constant = newValue
        }
        
        get {
            return dotView.superview?.constraints.filter({return $0.identifier == HzyDotConstraintType.right.rawValue}).first?.constant ?? 0
        }
    }
    
    public var dotTop: CGFloat {
        set {
            dotView.superview?.constraints.filter({return $0.identifier == HzyDotConstraintType.top.rawValue}).first?.constant = newValue
        }
        get {
            return dotView.superview?.constraints.filter({return $0.identifier == HzyDotConstraintType.top.rawValue}).first?.constant ?? 0
        }
    }
    
    public var dotWidth: CGFloat {
        set {
            dotView.constraints.filter({return $0.identifier == HzyDotConstraintType.width.rawValue}).first?.constant = newValue
        }
        
        get {
            return dotView.constraints.filter({return $0.identifier == HzyDotConstraintType.width.rawValue}).first?.constant ?? 0
        }
    }
    
    public var dotHeight: CGFloat {
        set {
            dotView.constraints.filter({return $0.identifier == HzyDotConstraintType.height.rawValue}).first?.constant = newValue
        }
        
        get {
            return dotView.constraints.filter({return $0.identifier == HzyDotConstraintType.height.rawValue}).first?.constant ?? 0
        }
    }
    
    public var dotCornerRadius: CGFloat {
        set{
            dotView.layer.cornerRadius = newValue
        }
        get {
            return dotView.layer.cornerRadius
        }
    }
}

extension UIView : HzyDotable {}

