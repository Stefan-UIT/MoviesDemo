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
    
    class func load<T>(_ type: T.Type, fromStoryboard storyboardName: String) -> T? where T: UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = String(describing: T.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            return nil
        }
        return controller
    }
    
    class func setToRootViewController(_ controller: UIViewController) {
        guard let currentWindow = window else {
            return
        }
        currentWindow.rootViewController = controller
    }
}
