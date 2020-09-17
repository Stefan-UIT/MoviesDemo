//
//  BookingViewController.swift
//  MoviesDemo
//
//  Created by Trung Vo on 9/17/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit
import WebKit

class BookingViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myURL = URL(string:"https://www.cathaycineplexes.com.sg/") else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
}
