//
//  KKBonusContentViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/05/2021.
//

import Foundation
import UIKit
import WebKit

class KKBonusContentViewController: KKBaseViewController {
    
    @IBOutlet weak var contentWebView: WKWebView!

    var htmlContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        
        if !htmlContent.isEmpty {
            contentWebView.loadHTMLString(htmlContent, baseURL: nil)
        }

    }
}
