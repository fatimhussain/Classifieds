//
//  Helper.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import UIKit

class Helper {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
    
    // find top most view controller
    static func topController() -> UIViewController? {
        
        func findTopMostController(_ from: UIViewController?) -> UIViewController? {
            if let tabController = (from as? UITabBarController)?.selectedViewController {
                return findTopMostController(tabController)
            } else if let visibleViewController = (from as? UINavigationController)?.visibleViewController {
                return findTopMostController(visibleViewController)
            } else if let presentedViewController = from?.presentedViewController {
                return findTopMostController(presentedViewController)
            } else {
                return from
            }
        }
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let root =  keyWindow?.rootViewController else {
            return nil
        }
        
        return findTopMostController(root)
    }
}
