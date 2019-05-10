//
//  UIStoryboardExtension.swift
//  hzy
//
//  Created by hzy on 2018/5/14.
//  Copyright © 2018年 hzy. All rights reserved.
//

import UIKit

extension UIStoryboard {
    public static func instantiateInitialViewController (storyboardName: String, bundle: String? = nil) ->UIViewController?{
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
    }
}

extension HzyNamespaceWrapper where T: UIStoryboard {
   public static func instantiateInitialViewController (storyboardName: String, bundle: String? = nil) ->UIViewController?{
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
    }
}
