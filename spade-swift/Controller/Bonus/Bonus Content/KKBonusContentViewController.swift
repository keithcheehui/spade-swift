//
//  KKBonusContentViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/05/2021.
//

import Foundation
import UIKit
import WebKit

class KKBonusContentViewController: KKBaseViewController, WKNavigationDelegate {
    
    @IBOutlet weak var contentWebView: WKWebView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!

    var htmlContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        
        contentWebView.navigationDelegate = self
        contentWebView.isOpaque = false
        contentWebView.addSubview(loadingActivity)
        contentWebView.clipsToBounds = true

        loadingActivity.color = .spade_white_FFFFFF
        loadingActivity.startAnimating()
        loadingActivity.hidesWhenStopped = true
    }
    
    func initialLayout(){
        
        if !htmlContent.isEmpty {
            contentWebView.loadHTMLString(htmlContent, baseURL: nil)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActivity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingActivity.stopAnimating()
    }
}
