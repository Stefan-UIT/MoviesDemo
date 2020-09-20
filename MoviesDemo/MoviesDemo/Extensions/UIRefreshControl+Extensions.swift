//
//  UIRefreshControl+Extensions.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/20/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    static func appRefreshControl(target: UIViewController,
                                  title: String = Messages.pullToRefresh,
                                  selector: Selector,
                                  for event: UIControl.Event = .valueChanged) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(target, action: selector, for: event)
        
        return refreshControl
    }
}
