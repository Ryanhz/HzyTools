//
//  UIViewExtension.swift
//  hzy
//
//  Created by hzy on 2017/11/1.
//  Copyright © 2017年 hzy. All rights reserved.
//

import UIKit

//extension UIView: HzyNamespaceWrappable {}
extension HzyNamespaceWrapper where T: UIView {
    /// viewOrigin
    public var viewOrigin : CGPoint {
        
        get { return wrappedValue.frame.origin}
        
        set(newVal) {
            
            var tmpFrame         = wrappedValue.frame
            tmpFrame.origin      = newVal
            wrappedValue.frame   = tmpFrame
        }
    }
    
    /// viewSize
    public var viewSize : CGSize {
        
        get{ return wrappedValue.frame.size}
        set(newVal) {
            
            var tmpFrame        = wrappedValue.frame
            tmpFrame.size       = newVal
            wrappedValue.frame  = tmpFrame
        }
    }
    
    /// x
    public var x : CGFloat {
        
        get { return wrappedValue.frame.origin.x}
        
        set(newVal) {
            
            var tmpFrame        = wrappedValue.frame
            tmpFrame.origin.x   = newVal
            wrappedValue.frame  = tmpFrame
        }
    }
    
    /// y
    public var y : CGFloat {
        
        get { return wrappedValue.frame.origin.y}
        
        set(newVal) {
            
            var tmpFrame        = wrappedValue.frame
            tmpFrame.origin.y   = newVal
            wrappedValue.frame  = tmpFrame
        }
    }
    
    /// height
    public var height : CGFloat {
        
        get { return wrappedValue.frame.size.height}
        
        set(newVal) {
            
            var tmpFrame            = wrappedValue.frame
            tmpFrame.size.height    = newVal
            wrappedValue.frame      = tmpFrame
        }
    }
    
    /// width
    public var width : CGFloat {
        
        get { return wrappedValue.frame.size.width}
        
        set(newVal) {
            
            var tmpFrame           = wrappedValue.frame
            tmpFrame.size.width    = newVal
            wrappedValue.frame     = tmpFrame
        }
    }
    
    /// left
    public var left : CGFloat {
        
        get { return wrappedValue.frame.origin.x}
        
        set(newVal) {
            
            var tmpFrame        = wrappedValue.frame
            tmpFrame.origin.x   = newVal
            wrappedValue.frame  = tmpFrame
        }
    }
    
    /// right
    public var right : CGFloat {
        
        get { return wrappedValue.frame.origin.x + wrappedValue.frame.size.width}
        
        set(newVal) {
            
            var tmpFrame        = wrappedValue.frame
            tmpFrame.origin.x   = newVal - wrappedValue.frame.size.width
            wrappedValue.frame  = tmpFrame
        }
    }
    
    /// top
    public var top : CGFloat {
        
        get { return wrappedValue.frame.origin.y}
        
        set(newVal) {
            
            var tmpFrame        = wrappedValue.frame
            tmpFrame.origin.y   = newVal
            wrappedValue.frame  = tmpFrame
        }
    }
    
    /// bottom
    public var bottom : CGFloat {
        
        get { return wrappedValue.frame.origin.y + wrappedValue.frame.size.height}
        
        set(newVal) {
            
            var tmpFrame        = wrappedValue.frame
            tmpFrame.origin.y   = newVal - wrappedValue.frame.size.height
            wrappedValue.frame  = tmpFrame
        }
    }
    
    /// centerX
    public var centerX : CGFloat {
        
        get { return wrappedValue.center.x}
        set(newVal) { wrappedValue.center = CGPoint(x: newVal, y: wrappedValue.center.y)}
    }
    
    /// centerY
    public var centerY : CGFloat {
        
        get { return wrappedValue.center.y}
        set(newVal) { wrappedValue.center = CGPoint(x: wrappedValue.center.x, y: newVal)}
    }
    
    /// middleX
    public var middleX : CGFloat {
        
        get { return wrappedValue.bounds.width / 2}
    }
    
    /// middleY
    public var middleY : CGFloat {
        get { return wrappedValue.bounds.height / 2}
    }
    /// middlePoint
    public var middlePoint : CGPoint {
        get { return CGPoint(x: wrappedValue.bounds.width / 2, y: wrappedValue.bounds.height / 2)}
    }
}

// MARK: ---<##>extension UIView
extension UIView {
    
    /// viewOrigin
    public var viewOrigin : CGPoint {
        
        get { return frame.origin}
        
        set(newVal) {
            
            var tmpFrame    = frame
            tmpFrame.origin = newVal
            frame           = tmpFrame
        }
    }
    
    /// viewSize
    public var viewSize : CGSize {
        
        get{ return frame.size}
        set(newVal) {
            
            var tmpFrame  = frame
            tmpFrame.size = newVal
            frame         = tmpFrame
        }
    }
    
    /// x
    public var x : CGFloat {
        get { return frame.origin.x}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// y
    public var y : CGFloat {
        get { return frame.origin.y}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame             = tmpFrame
        }
    }
    
    /// height
    public var height : CGFloat {
        
        get { return frame.size.height}
        set(newVal) {
            var tmpFrame         = frame
            tmpFrame.size.height = newVal
            frame                = tmpFrame
        }
    }
    
    /// width
    public var width : CGFloat {
        
        get { return frame.size.width}
        set(newVal) {
            var tmpFrame        = frame
            tmpFrame.size.width = newVal
            frame               = tmpFrame
        }
    }
    
    /// left
    public var left : CGFloat {
        get { return frame.origin.x}
        set(newVal) {
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// right
    public var right : CGFloat {
        get { return frame.origin.x + frame.size.width}
        set(newVal) {
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal - frame.size.width
            frame             = tmpFrame
        }
    }
    
    /// top
    public var top : CGFloat {
        
        get { return frame.origin.y}
        set(newVal) {
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame = tmpFrame
        }
    }
    
    /// bottom
    public var bottom : CGFloat {
        
        get { return frame.origin.y + frame.size.height}
        set(newVal) {
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal - frame.size.height
            frame             = tmpFrame
        }
    }
    
    /// centerX
    public var centerX : CGFloat {
        get { return center.x}
        set(newVal) { center = CGPoint(x: newVal, y: center.y)}
    }
    
    /// centerY
   public var centerY : CGFloat {
        get { return center.y}
        set(newVal) { center = CGPoint(x: center.x, y: newVal)}
    }
    
    /// middleX
    public var middleX : CGFloat {
        get { return bounds.width / 2}
    }
    
    /// middleY
    public var middleY : CGFloat {
        get { return bounds.height / 2}
    }
    
    /// middlePoint
    public var middlePoint : CGPoint {
        get { return CGPoint(x: bounds.width / 2, y: bounds.height / 2)}
    }

}


