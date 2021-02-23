//
//  WebViewController.swift
//  WeatherApp
//
//  Created by N, Narasimhulu on 19/02/21.
//  Copyright © 2021 Narasimha. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.configuration.preferences.javaScriptEnabled = true
        view = webView
        
        let path = Bundle.main.path(forResource: "Help", ofType: "txt")
        do {
            let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
            webView?.loadHTMLString( headerString + string, baseURL: nil)
        } catch {
            print("Failed reading from URL: \(path!), Error: " + error.localizedDescription)
        }
        
    }
    
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
}
