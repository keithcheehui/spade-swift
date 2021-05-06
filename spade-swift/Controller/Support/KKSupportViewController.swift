//
//  KKSupportViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKSupportViewController: KKBaseViewController {
    
    @IBOutlet weak var lblLiveChat: UILabel!
    @IBOutlet weak var lblFaq: UILabel!
    @IBOutlet weak var imgHoverLiveChat: UIImageView!
    @IBOutlet weak var imgHoverFaq: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    
    enum viewType: Int {
        case liveChat = 0
        case faq = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.liveChat.rawValue)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblLiveChat.text = KKUtil.languageSelectedStringForKey(key: "support_live_chat")
        lblFaq.text = KKUtil.languageSelectedStringForKey(key: "support_faq")
        
        lblLiveChat.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblFaq.font = lblLiveChat.font
    }
    
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLiveChatDidPressed(){
        buttonHover(type: viewType.liveChat.rawValue)
    }
    
    @IBAction func btnFaqDidPressed(){
        buttonHover(type: viewType.faq.rawValue)
    }

    func buttonHover(type: Int){
        imgHoverLiveChat.isHidden = true
        imgHoverFaq.isHidden = true
        
        var viewController: UIViewController = KKOnBoardingViewController()
        
        switch type {
        case viewType.faq.rawValue:
            imgHoverFaq.isHidden = false
            viewController = KKPersonalViewController()
            break;
        default:
            imgHoverLiveChat.isHidden = false
            viewController = KKOnBoardingViewController()
            break;
        }
        
        changeView(vc: viewController)
    }
    
    func changeView(vc: UIViewController){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
}
