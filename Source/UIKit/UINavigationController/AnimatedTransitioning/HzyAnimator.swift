//
//  HzyAnimator.swift
//  edit
//
//  Created by hzf on 2018/10/17.
//  Copyright © 2018年 hzf. All rights reserved.
//

import UIKit

class HzyAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //上一个controller
        let toController = transitionContext.viewController(forKey: .to)!
        
        let fromeController = transitionContext.viewController(forKey: .from)!
        
        let containerView = transitionContext.containerView
        
        containerView.insertSubview(toController.view, aboveSubview: fromeController.view)
        
        //设置下一个Controller的frame
        toController.view.frame = transitionContext.finalFrame(for: toController)
        
        let nextControllerXTranslation = containerView.width
        toController.view.transform = CGAffineTransform.init(translationX: nextControllerXTranslation, y: 0)
        
        //设置左侧阴影
        toController.view.addLeftSideShadowWithFading()
        
         //黑色蒙层
        let dimmingView = UIView(frame: fromeController.view.bounds)
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        dimmingView.alpha = 0
        fromeController.view.addSubview(dimmingView)
        
        let nextClipsToBounds = fromeController.view.clipsToBounds
        toController.view.clipsToBounds = false
        
        let tabBarController = fromeController.tabBarController
        let navController = fromeController.navigationController
        let tabBar = tabBarController?.tabBar
    }
}


extension UIView {
    
    func addLeftSideShadowWithFading() {
        let shadowRect = CGRect(x: -4, y: -1, width: 4, height: self.height-2)
        let shadowPath = UIBezierPath(rect: shadowRect)
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowOpacity = 0.2
        
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = self.layer.shadowOpacity
        animation.toValue = 0.1
        self.layer.add(animation, forKey: nil)
        self.layer.shadowOpacity = 0.1
        
    }
}
