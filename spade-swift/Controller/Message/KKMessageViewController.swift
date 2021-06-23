//
//  KKMessageViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKMessageViewController: KKBaseViewController {
    
    @IBOutlet weak var lblSystemMail: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var imgHoverSystemMail: UIImageView!
    @IBOutlet weak var imgHoverNotification: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    
    enum viewType: Int {
        case systemMail = 0
        case notification = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.systemMail.rawValue)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblSystemMail.text = KKUtil.languageSelectedStringForKey(key: "message_system_mail")
        lblNotification.text = KKUtil.languageSelectedStringForKey(key: "message_notification")
        
        lblSystemMail.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblNotification.font = lblSystemMail.font
    }
    
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSystemMailDidPressed(){
        buttonHover(type: viewType.systemMail.rawValue)
    }
    
    @IBAction func btnNotificationDidPressed(){
        buttonHover(type: viewType.notification.rawValue)
    }

    func buttonHover(type: Int){
        imgHoverSystemMail.isHidden = true
        imgHoverNotification.isHidden = true
                
        switch type {
        case viewType.notification.rawValue:
            imgHoverNotification.isHidden = false
            changeView(vc: KKOnBoardingViewController())
            break;
        default:
            imgHoverSystemMail.isHidden = false
            changeView(vc: KKMessageListViewController())
            break;
        }
    }
    
    func changeView(vc: KKBaseViewController){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        vc.tableContentView = contentView
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
}
