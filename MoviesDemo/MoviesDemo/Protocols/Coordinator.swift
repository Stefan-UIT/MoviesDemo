//
//  Coordinator.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/20/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start(withViewController viewController: BaseViewController)
}
