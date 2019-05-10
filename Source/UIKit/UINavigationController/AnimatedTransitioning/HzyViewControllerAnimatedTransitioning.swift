//
//  HzyCustomTransitionAnimator.swift
//  edit
//
//  Created by hzf on 2018/10/15.
//  Copyright © 2018年 hzf. All rights reserved.
//

import UIKit

enum HzyCustomTransitionAnimatorType {
    case push
    case pop
}

protocol HzyViewControllerAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    var type: HzyCustomTransitionAnimatorType { get set }
    var canInteractive: Bool { get set }
    var enable: Bool { get set }
}
