//
//  HzySwiper.swift
//  edit
//
//  Created by hzf on 2018/10/16.
//  Copyright © 2018年 hzf. All rights reserved.
//

import UIKit

protocol HzySwiperDelegate: class {
    
}

enum HzyPanSwiperDirection {
    case none, left , right//, top, bottom
}

class HzySwiper: NSObject {

    var defaultProgressPushValue: CGFloat = 0.5
    var defaultProgressPopValue: CGFloat = 0.5
    
    public var canInteractive: Bool = false {
        didSet {
            guard let gesture = navigationController.interactivePopGestureRecognizer, let gestureView = gesture.view else {
                return
            }
            if canInteractive {
                gesture.isEnabled = false
                gestureView.addGestureRecognizer(panRecognizer)
            } else {
                gesture.isEnabled = true
                gestureView.removeGestureRecognizer(panRecognizer)
            }
        }
    }
    
    var isCustomAnimator: Bool = true {
        didSet {
            if isCustomAnimator {
                self.navigationController.delegate = self
            } else {
                self.navigationController.delegate = nil;
            }
        }
    }
    
    weak var delegate: HzySwiperDelegate?
    weak var navigationController: UINavigationController!
    var panDirection: HzyPanSwiperDirection = .none
    var isInteracting: Bool = false
    var interactiveTransition: HzyInteractiveTransition = HzyInteractiveTransition()
    var panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleWithPan(_:)))
    
    var animator: HzyViewControllerAnimatedTransitioning?
    
    init(navigationController: UINavigationController) {
        super.init()
        panRecognizer.maximumNumberOfTouches = 1
        self.navigationController = navigationController
        navigationController.delegate = self
    }
    
    //更新拖拽方向
    func updatePanDirection(velocity_x: CGFloat){
        if (velocity_x > 0) {
            panDirection = .right;
        }else if (velocity_x < 0) {
            panDirection = .left
        }else {
            panDirection = .none;
        }
    }
    
    @objc func handleWithPan(_ recognizer: UIPanGestureRecognizer) {
        
        //偏移量
        let translation_x = recognizer.translation(in: recognizer.view!).x
        
        //进度
        let progress = translation_x / recognizer.view!.width;
        
        switch recognizer.state {
        case .began:
            //速度
            let velocity_x = recognizer.velocity(in: recognizer.view!).x
            updatePanDirection(velocity_x: velocity_x)
            panBegan(recognizer)
        case .changed:
            panChange(recognizer, progress: progress)
        case .ended, .cancelled:
           panEnd(recognizer, progress: progress)
        default:
            isInteracting = false
            interactiveTransition.cancel()
        }
    }
    
    func panBegan(_ recognizer: UIPanGestureRecognizer) {
        isInteracting = true
        self.animator = nil
      
        switch panDirection {
        case .left: //滑动push
      
            guard let viewController = self.navigationController.viewControllers.last as? HzyCustomPushPopAnimatorAble,
                let animator = viewController.pushAnimator,
                animator.canInteractive,
                let nextController = viewController.swiperPushNextViewController else {
                return
            }
            self.navigationController.pushViewController(nextController, animated: true)
            
        case .right: //pop
            if self.navigationController.viewControllers.count > 1 {
                self.navigationController.popToRootViewController(animated: true)
            }
        default:
            break
        }
    }
    
    func panChange(_ recognizer: UIPanGestureRecognizer, progress: CGFloat) {
        guard isInteracting else {
            return
        }
        var progress = progress
        switch panDirection {
        case .left:
            progress = progress > 0 ? 0 : abs(progress)
        default:
            break
        }
        progress = min(1, max(0, progress))
        interactiveTransition.update(progress)
    }
    
    func panEnd(_ recognizer: UIPanGestureRecognizer, progress: CGFloat){
        guard isInteracting else {
            return
        }
        
        isInteracting = false
        var progress = progress
        progress = min(1, max(0, progress))
        var defaultProgress: CGFloat = 0
        switch panDirection {
        case .left:
            progress = progress > 0 ? 0 : progress
            defaultProgress = defaultProgressPushValue
        case .right: //pop
            defaultProgress = defaultProgressPopValue

        default:
            break
        }
        progress > defaultProgress ? interactiveTransition.finish() : interactiveTransition.cancel()
    }
}

extension HzySwiper: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            if let viewController = fromVC as? HzyCustomPushPopAnimatorAble,
            let animator = viewController.pushAnimator,
                animator.canInteractive {
                self.animator = animator
                return animator
            }
            return nil
        case .pop:
            if let viewController = fromVC as? HzyCustomPushPopAnimatorAble,
                let animator = viewController.popAnimator,
                animator.canInteractive {
                self.animator = animator
                return animator
            }
            return nil
            
        case .none:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard self.isInteracting,
        let animator = self.animator,
        animator.canInteractive
        else {
            return nil
        }
        return interactiveTransition
    }
}
