//
//  UINavigationController+Theme.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

extension UINavigationController {
    func applyTheme() {
        navigationBar.barStyle = .black
        navigationBar.tintColor = UIColor(named: "steam_gold")
        
        let font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: font]
    }
}
