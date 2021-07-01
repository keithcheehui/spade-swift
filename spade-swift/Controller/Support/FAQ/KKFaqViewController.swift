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

    var faqArray: [KKFAQDetails]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFAQAPI()
        
        faqTableView.isHidden = true
        
        loadingActivity.color = .spade_white_FFFFFF
        faqWebView.addSubview(loadingActivity)
        loadingActivity.startAnimating()
        faqWebView.navigationDelegate = self
        loadingActivity.hidesWhenStopped = true
        
        faqWebView.clipsToBounds = true
    }
    
    //MARK:- API Calls
    
    func getFAQAPI() {
                
        KKApiClient.getFAQ().execute { [self] FAQResponse in
            
            self.faqArray = FAQResponse.results?.faqs
            
            if !faqArray[0].content!.isEmpty {
                faqWebView.loadHTMLString(faqArray[0].content!, baseURL: nil)
            }

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
