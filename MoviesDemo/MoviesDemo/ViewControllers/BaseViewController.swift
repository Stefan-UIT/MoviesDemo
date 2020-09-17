//
//  BaseViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    weak var coordinator: MainCoordinator?

}

// MARK: - Storyboarded
extension BaseViewController: Storyboarded {}
