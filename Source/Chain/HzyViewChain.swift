//
//  HzyUIViewChain.swift
//  hzy
//
//  Created by hzy on 2017/11/2.
//  Copyright © 2017年 hzy. All rights reserved.
//

import UIKit
//import SnapKit

public protocol HzyViewChainable {}
extension UIView: HzyViewChainable {}

extension HzyViewChainable where Self: UIView {
    @discardableResult
    public func addHere(toSuperview: UIView) -> Self {
        toSuperview.addSubview(self)
        return self
    }

//    @discardableResult
//    func layout(snapKitMaker: (ConstraintMaker) -> Void) -> Self {
//        guard  let _ = self.superview  else {
//            debugPrint("The parent view of \(self) cannot be empty")
//            return self
//        }
//        self.snp.makeConstraints { (maker) in
//            snapKitMaker(maker)
//        }
//        return self
//    }

    @discardableResult
    public func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
}



