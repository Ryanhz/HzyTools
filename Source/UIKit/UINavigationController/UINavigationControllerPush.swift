//
//  UINavigationControllerPush.swift
//  hzy
//
//  Created by hzy on 2018/5/22.
//  Copyright © 2018年 hzy. All rights reserved.
//
import UIKit

fileprivate var HzyInteractionDelegateKey: UInt8 = 0
fileprivate var HzyOriginalDelegateKey: UInt8 = 0
fileprivate var HzySwiperKey: UInt8 = 0

fileprivate var HzyCustomNavigationInteractiveTransitionOnceKey = "com.hzy.HzyCustomNavigationInteractiveTransitionOnceKey"
fileprivate var HzyCustomViewControllerViewWilAppearOnceKey = "com.hzy.HzyCustomViewControllerViewWilAppearOnceKey"

protocol HzyCustomPushPopAnimatorAble {
    var pushAnimator:  HzyViewControllerAnimatedTransitioning? { get set }
    var popAnimator: HzyViewControllerAnimatedTransitioning? { get set }
    var swiperPushNextViewController: UIViewController?{ get set }
}

protocol HzyPushPopScaleAnimatedTransitioningable: HzyCustomPushPopAnimatorAble {
    
    var transitionSourceView: UIView? { get set }
    var transitionTargetView: UIView? { get set }
}

extension UINavigationController {
    
    class func changePushPopMethod(){
        DispatchQueue.hzy.once(token: HzyCustomNavigationInteractiveTransitionOnceKey) {
            let systemPushSel = #selector(pushViewController(_:animated:))
            let swizzPushSel = #selector(hzyPush(_:animated:))
    
            let systemMethod = class_getInstanceMethod(self, systemPushSel)
            
            let swizzMethod = class_getInstanceMethod(self, swizzPushSel)
            
            let isAdd = class_addMethod(self, systemPushSel, method_getImplementation(swizzMethod!), method_getTypeEncoding(swizzMethod!))
            
            if isAdd {
                class_replaceMethod(self, swizzPushSel, method_getImplementation(systemMethod!), method_getTypeEncoding(systemMethod!));
            }else {
                method_exchangeImplementations(systemMethod!, swizzMethod!);
            }
        }
    }
    
    @objc fileprivate func hzyPush(_ viewController: UIViewController, animated flag: Bool){
    }
}

extension UIViewController {
    
    class func changeViewWillAppearMethod(){
        
        DispatchQueue.hzy.once(token: HzyCustomViewControllerViewWilAppearOnceKey) {
            
            let systemViewAppearSel = #selector(viewWillAppear(_:))
            
            let swizzPushViewAppearSel = #selector(hzyViewWillAppear(_:))
            
            let systemMethod = class_getInstanceMethod(self, systemViewAppearSel)
            
            let swizzMethod = class_getInstanceMethod(self, swizzPushViewAppearSel)
            
            let isAdd = class_addMethod(self, systemViewAppearSel, method_getImplementation(swizzMethod!), method_getTypeEncoding(swizzMethod!))
            
            if isAdd {
                class_replaceMethod(self, swizzPushViewAppearSel, method_getImplementation(systemMethod!), method_getTypeEncoding(systemMethod!));
            }else {
                method_exchangeImplementations(systemMethod!, swizzMethod!);
            }
        }
    }
    
    @objc fileprivate func hzyViewWillAppear(_  animated: Bool){
        hzyViewWillAppear(animated)
 
    }
}

extension HzyNamespaceWrapper where T: UIViewController {

}

extension HzyNamespaceWrapper where T: UINavigationController {
    
    public var openSwiper: Bool {
        set {
           swiper.canInteractive = newValue
        }
        get {
            return swiper.canInteractive
        }
    }
    
    var swiper: HzySwiper {
        get {
            return wrappedValue.associatedObject(key: &HzySwiperKey, {
                return HzySwiper(navigationController: wrappedValue)
            })
        }
    }
    
    public func pushViewController(viewController: UIViewController, animated flag: Bool) {
        
        UINavigationController.changePushPopMethod()
        UIViewController.changeViewWillAppearMethod()
    }
}
