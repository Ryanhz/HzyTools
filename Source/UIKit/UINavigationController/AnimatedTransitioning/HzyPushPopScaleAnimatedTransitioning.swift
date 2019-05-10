//
//  HzyPPScaleAnimation.swift
//  hzy
//
//  Created by hzy on 2018/5/22.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit

class HzyPushPopScaleAnimatedTransitioning: NSObject, HzyViewControllerAnimatedTransitioning {

    var canInteractive: Bool = true
    
    var enable: Bool = true
    
    var type: HzyCustomTransitionAnimatorType
    
    override init() {
        type = .push;
    }
    
//    /// 动画执行的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        switch self.type {
        case .pop:
            animationForPop(transitionContext)
        case .push:
            animationForPush(transitionContext)
        }
    }

    fileprivate func animationForPush(_ transitionContext: UIViewControllerContextTransitioning) {

        guard let fromP = transitionContext.viewController(forKey: .from) as? HzyPushPopScaleAnimatedTransitioningable,
            let toP = transitionContext.viewController(forKey: .to) as? HzyPushPopScaleAnimatedTransitioningable else {
            transitionContext.completeTransition(false)
            return
        }
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        
        let fromView = fromVC.view!
        let toView = toVC.view!
        
        let containerView = transitionContext.containerView
        
        let containerViewColor = containerView.backgroundColor
        containerView.backgroundColor = UIColor.white
        
        guard let sourceView = fromP.transitionSourceView,
        let destinationView = toP.transitionTargetView else {
            transitionContext.completeTransition(false)
            return
        }
        
        let sourcePoint = sourceView.convert(CGPoint.zero, to: nil)
        let destinationPoint = destinationView.convert(CGPoint.zero, to: nil)
        let sourceFrame = fromView.convert(sourceView.frame, to: containerView)
        let destinationFrame = toView.convert(destinationView.frame, to: containerView)
        
        let snapShot = sourceView.snapshotView(afterScreenUpdates: false)!
        snapShot.frame = sourceFrame
        
        let heightScale = destinationView.height/sourceView.height
        let widthScale = destinationView.width/sourceView.height
        
        let originFrame = fromView.frame
        sourceView.isHidden = true
        toView.isHidden = true
        containerView.addSubview(toView)
        containerView.addSubview(snapShot)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            snapShot.frame = destinationFrame
            fromView.alpha = 0
            fromView.transform = .init(scaleX: widthScale, y: heightScale)
            fromView.viewOrigin = CGPoint(x: (destinationPoint.x - sourcePoint.x) * widthScale, y: (destinationPoint.y - sourcePoint.y) * heightScale)
            
        }) { (finished) in
            containerView.backgroundColor = containerViewColor
            snapShot.removeFromSuperview()
            toView.isHidden = false
            fromView.alpha = 1
            sourceView.isHidden = false
            fromView.transform = .identity
            fromView.frame = originFrame
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    // 自定义消失动画
    fileprivate func animationForPop(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromP = transitionContext.viewController(forKey: .from) as? HzyPushPopScaleAnimatedTransitioningable,
            let toP = transitionContext.viewController(forKey: .to) as? HzyPushPopScaleAnimatedTransitioningable else {
                transitionContext.completeTransition(false)
                return
        }

        guard let sourceView = fromP.transitionTargetView,
            let destinationView = toP.transitionSourceView  else {
                transitionContext.completeTransition(false)
                return
        }
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        
        let fromView = fromVC.view!
        let toView = toVC.view!
        
        
        let containerView = transitionContext.containerView
        let containerViewColor = containerView.backgroundColor
        
        toView.frame = containerView.bounds
        containerView.addSubview(toView)
        containerView.backgroundColor = .white// containerViewColor
        
        let sourcePoint = sourceView.convert(CGPoint.zero, to: nil)
        let destinationPoint = destinationView.convert(CGPoint.zero, to: nil)
        
        let snapShot = sourceView.snapshotView(afterScreenUpdates: true) ?? UIView()
        
        snapShot.viewOrigin = sourcePoint
        snapShot.viewSize = sourceView.viewSize
        containerView.addSubview(snapShot)
        
        let heightScale = destinationView.height/sourceView.height
        let widthScale = destinationView.width/sourceView.height
        
        let originFrame = toView.frame
        let originHeightScale = sourceView.height/destinationView.height
        let originWidthScale = sourceView.width/destinationView.width
        
        toView.transform = .init(scaleX: originWidthScale, y: originHeightScale)
        toView.viewOrigin = CGPoint(x: (sourcePoint.x - destinationPoint.x)*originWidthScale, y:(sourcePoint.y - destinationPoint.y)*originHeightScale);
        
        toView.alpha = 0
        fromView.isHidden = true
        destinationView.isHidden = true
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            snapShot.transform = .init(scaleX: widthScale, y: heightScale)
            snapShot.viewOrigin = destinationPoint
            toView.alpha = 1.0
            toView.transform = .identity
            toView.frame = originFrame;
        }) { (finished) in
            containerView.backgroundColor = containerViewColor
            fromView.isHidden = false
            destinationView.isHidden = false
            snapShot.removeFromSuperview()
            toView.transform = .identity
            toView.frame = originFrame
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
