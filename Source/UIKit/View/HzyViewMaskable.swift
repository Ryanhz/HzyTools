//
//  HzyViewMaskable.swift
//  hzy
//
//  Created by hzy on 2018/2/26.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit
protocol HzyViewMaskable {}

extension UIView: HzyViewMaskable{}
extension UIRectCorner: HzyNamespaceWrappable{}

extension UIRectCorner {
    static let top: UIRectCorner  = [.topLeft, .topRight]
    static let bottom: UIRectCorner = [.bottomLeft, .bottomRight]
    static let left: UIRectCorner = [.topLeft, .bottomLeft]
    static let right: UIRectCorner = [.topRight, .bottomRight]
    static let all: UIRectCorner = UIRectCorner.allCorners
}

extension HzyViewMaskable where Self: UIView {
    /**
     对UIView及其子类进行上边或者下边切角
     
     - parameter view:  需要切割的View
     - parameter isTop: 是否是上边界
     */
    func cornerRadii(cornerTypes: UIRectCorner, cornerRadii: CGSize){
        let maskPath : UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerTypes , cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

extension HzyNamespaceWrapper where T == UIRectCorner {
    public static var top: UIRectCorner  { return  UIRectCorner.top }
    public static var bottom: UIRectCorner  { return  UIRectCorner.bottom }
    public static var left: UIRectCorner  { return  UIRectCorner.left }
    public static var right: UIRectCorner  { return  UIRectCorner.right }
    public static var all: UIRectCorner  { return  UIRectCorner.all }
}

extension HzyNamespaceWrapper where T: UIView {
    public func cornerRadii(cornerTypes: UIRectCorner, cornerRadii: CGSize){
        let maskPath : UIBezierPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners: cornerTypes , cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = wrappedValue.bounds
        maskLayer.path = maskPath.cgPath
        wrappedValue.layer.mask = maskLayer
    }
}


