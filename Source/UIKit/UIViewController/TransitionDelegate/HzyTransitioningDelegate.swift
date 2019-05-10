//
//  HzyTransitioningDelegate.swift
//  hzy
//
//  Created by hzy on 2018/5/18.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit

public protocol HzyTransitioningDelegateable {
    var portrait: CGRect? {get set}
    var landScape: CGRect? {get set}
    var maskColor: UIColor? {get set}
}

protocol HzyTransitioningAnimatorable: UIViewControllerAnimatedTransitioning {
    var isPresent: Bool{get set}
}

public class HzyTransitioningDelegate: NSObject {

   public enum PresentTransionStyle: String {
        case circle = "circle"
        case backScale = "backScale"
        case rightToLeft = "rightToLeft"
        case leftToRight = "leftToRight"
        case bottomToTop = "bottomToTop"
        case show = "show"
    }
    
    fileprivate var presentTransionStyle: PresentTransionStyle
    fileprivate var animator: HzyTransitioningAnimatorable
    
    public var portrait: CGRect?
    public var landScape: CGRect?
    public var maskColor: UIColor?
    
    public init(presentTransionStyle: PresentTransionStyle) {
        self.presentTransionStyle = presentTransionStyle
        switch presentTransionStyle {
        case .bottomToTop:
             self.animator = HzyPresentSimpleAnimation(.bottomToTop)
        case .leftToRight:
            self.animator = HzyPresentSimpleAnimation(.leftToRight)
        case .rightToLeft:
            self.animator = HzyPresentSimpleAnimation(.rightToLeft)
        case .show:
            self.animator = HzyPresentSimpleAnimation(.show)
        default:
            self.animator = HzyPresentBackScaleAnimation()
        }
    }
}

// MARK:- 自定义转场代理的方法
extension HzyTransitioningDelegate : UIViewControllerTransitioningDelegate {

    // 目的:改变弹出View的尺寸
    private func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentation = HzyPresentationController(presentedViewController: presented, presenting: presenting)
        if  presentTransionStyle != .circle {
            presentation.presentedPortraitFrame = portrait
            presentation.presentedLandscapeFrame = landScape
            presentation.maskBackgroundColor = maskColor
        }
        return presentation
    }
    
    // 目的:自定义弹出的动画
    private func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
         animator.isPresent = true
        return animator
    }
    
    // 目的:自定义消失的动画
    private func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.isPresent =  false
        return animator 
    }
    
    private func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}





