//
//  UIScreenExtension.swift
//  hzy
//
//  Created by hzy on 2017/11/1.
//  Copyright © 2017年 hzy. All rights reserved.
//

import UIKit

extension UIScreen {
    
    public class var size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    public class var minWidth: CGFloat {
        return min(self.size.width, self.size.height)
    }
    
    public class var maxHeight: CGFloat {
        return max(self.size.width, self.size.height)
    }
    
    public class var width: CGFloat {
        return min(self.size.width, self.size.height)
    }
    
    public class var height: CGFloat {
        return max(self.size.width, self.size.height)
    }
    
    public class var mainScale: CGFloat {
        return UIScreen.main.scale
    }
    
    public class var mainbounds: CGRect {
        return UIScreen.main.bounds
    }
    
    public static var  px1: CGFloat{return 1/UIScreen.hzy.scale}
    
    public static var statusBarHeight: CGFloat{ return UIApplication.shared.statusBarFrame.height }
    public static var navigationBarHeight: CGFloat = 44
    public static var navHeitht: CGFloat{
        return  statusBarHeight +  navigationBarHeight
    }
    
    ///iPhoneX 底部不可用区域
    public static var extraBottom: CGFloat {
        if UIDevice.hzy.isScreenElongation {
            return 34
        }
        return 0
    }
}

extension HzyNamespaceWrapper where T: UIScreen {
    
    public static var size: CGSize { return UIScreen.main.bounds.size }
    
    public static var width: CGFloat { return self.size.width }
    
    public static var height: CGFloat { return self.size.height }
    
    public static var minWidth: CGFloat { return min(UIScreen.size.width, UIScreen.size.height) }
    
    public static var maxHeight: CGFloat { return max(UIScreen.size.width, UIScreen.size.height) }
    
    public static var scale: CGFloat { return UIScreen.main.scale }
    
    public static var bounds: CGRect { return UIScreen.main.bounds }
    
    public static var  px1: CGFloat{ return 1 / UIScreen.hzy.scale}
    
    public static var statusBarHeight: CGFloat{ return UIApplication.shared.statusBarFrame.height }
    
    public static var navigationBarHeight: CGFloat { return 44 }
    
    public static var navHeitht: CGFloat{ return  statusBarHeight +  navigationBarHeight }
    
    ///iPhoneX 底部不可用区域
    public static var extraBottom: CGFloat { return  UIDevice.hzy.isScreenElongation ? 34 : 0 }
}


