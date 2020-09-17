//
//  ControllerHelper.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class ControllerHelper {
    class var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    class func setToRootViewController(_ controller: UIViewController) {
        guard let currentWindow = window else {
            return
        }
        currentWindow.rootViewController = controller
    }
}
