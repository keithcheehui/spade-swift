//
//  KKFaqViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 09/05/2021.
//

import Foundation
import UIKit
import WebKit

class KKFaqViewController: KKBaseViewController, WKNavigationDelegate {
    
    @IBOutlet weak var faqTableView: UITableView!
    @IBOutlet weak var faqWebView: WKWebView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFAQAPI()
        
        faqTableView.isHidden = true
        
        faqWebView.navigationDelegate = self
        faqWebView.isOpaque = false
        faqWebView.addSubview(loadingActivity)
        faqWebView.clipsToBounds = true

        loadingActivity.color = .spade_white_FFFFFF
        loadingActivity.startAnimating()
        loadingActivity.hidesWhenStopped = true
    }
    
    //MARK:- API Calls
    
    func getFAQAPI() {
                
        KKApiClient.getFAQ().execute { [self] FAQResponse in
            self.faqWebView.loadHTMLString(FAQResponse.results?.faq ?? "", baseURL: nil)
        } onFailure: { errorMessage in
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActivity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingActivity.stopAnimating()
    }
}
