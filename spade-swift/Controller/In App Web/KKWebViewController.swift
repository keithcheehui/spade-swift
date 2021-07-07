//
//  KKWebViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 07/07/2021.
//

import UIKit
import WebKit

class KKWebViewController: KKBaseViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var draggableView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.addSubview(loadingActivity)
        webView.clipsToBounds = true

        loadingActivity.color = .spade_white_FFFFFF
        loadingActivity.startAnimating()
        loadingActivity.hidesWhenStopped = true
              
        webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
        
        self.draggableView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handler)))
    }
    
    @objc
    func handler(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.view)
        let draggedView = gesture.view
        draggedView?.center = location
        
        if gesture.state == .ended {
            if self.draggableView.frame.midX >= self.view.layer.frame.width / 4 * 3 || self.draggableView.frame.midX >= self.view.layer.frame.width {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.draggableView.center.x = self.view.layer.frame.width - 60 //To right
                }, completion: nil)
            } else if self.draggableView.frame.midX <= self.view.layer.frame.width / 4 || self.draggableView.frame.midX <= 0 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.draggableView.center.x = 60 //To left
                }, completion: nil)
            } else if self.draggableView.frame.midY <= self.view.layer.frame.height / 2 || self.draggableView.frame.midY <= 0 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.draggableView.center.y = 40 //To top
                }, completion: nil)
            } else if self.draggableView.frame.midY >= self.view.layer.frame.height / 2 || self.draggableView.frame.midY >= self.view.layer.frame.height {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.draggableView.center.y = self.view.layer.frame.height - 40 //To bottom
                }, completion: nil)
            }
            
            if self.draggableView.center.y >= self.view.layer.frame.height - 40 {
                self.draggableView.center.y = self.view.layer.frame.height - 40
            }
            if self.draggableView.center.y <= 40 {
                self.draggableView.center.y = 40
            }
        }
    }
    
    @IBAction func btnBackDidPressed() {
        let viewController = KKDialogAlertViewController.init()
        viewController.alertType = .ExitGame
        viewController.webViewController = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func closeDialogAndPop() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

extension KKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActivity.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingActivity.stopAnimating()
    }
}
