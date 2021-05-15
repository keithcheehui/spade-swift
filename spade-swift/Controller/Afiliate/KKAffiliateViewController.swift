//
//  KKAffiliateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKAffiliateViewController: KKBaseViewController {
    
    @IBOutlet weak var lblMyAffiliate: UILabel!
    @IBOutlet weak var lblDownline: UILabel!
    @IBOutlet weak var lblGuideline: UILabel!
    @IBOutlet weak var lblTurnover: UILabel!
    @IBOutlet weak var imgHoverMyAffiliate: UIImageView!
    @IBOutlet weak var imgHoverDownline: UIImageView!
    @IBOutlet weak var imgHoverGuideline: UIImageView!
    @IBOutlet weak var imgHoverTurnover: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgBG: UIImageView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!

    enum viewType: Int {
        case myAffiliate = 0
        case downline = 1
        case guideline = 2
        case turnover = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.myAffiliate.rawValue)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft

        headerContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 30)
        menuItemMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 15)
        
        lblMyAffiliate.text = KKUtil.languageSelectedStringForKey(key: "affiliates_my_affiliate")
        lblDownline.text = KKUtil.languageSelectedStringForKey(key: "affiliates_downline")
        lblGuideline.text = KKUtil.languageSelectedStringForKey(key: "affiliates_guideline")
        lblTurnover.text = KKUtil.languageSelectedStringForKey(key: "affiliates_turnover")
        
        lblMyAffiliate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblDownline.font = lblMyAffiliate.font
        lblGuideline.font = lblMyAffiliate.font
        lblTurnover.font = lblMyAffiliate.font
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMyAffiliateDidPressed(){
        buttonHover(type: viewType.myAffiliate.rawValue)
    }
    
    @IBAction func btnDownlineDidPressed(){
        buttonHover(type: viewType.downline.rawValue)
    }

    @IBAction func btnGuidelineDetailsDidPressed(){
        buttonHover(type: viewType.guideline.rawValue)
    }
    
    @IBAction func btnTurnoverDidPressed(){
        buttonHover(type: viewType.turnover.rawValue)
    }
    
    func buttonHover(type: Int){
        imgBG.isHidden = false

        imgHoverMyAffiliate.isHidden = true
        imgHoverDownline.isHidden = true
        imgHoverGuideline.isHidden = true
        imgHoverTurnover.isHidden = true

        var viewController: UIViewController = KKOnBoardingViewController()
        
        switch type {
        case viewType.downline.rawValue:
            imgHoverDownline.isHidden = false
            viewController = KKPersonalViewController()
            break;
        case viewType.guideline.rawValue:
            imgHoverGuideline.isHidden = false
            viewController = KKGuidelineViewController()
            break;
        case viewType.turnover.rawValue:
            imgHoverTurnover.isHidden = false
            viewController = KKPersonalViewController()
            break;
        default:
            imgBG.isHidden = true
            imgHoverMyAffiliate.isHidden = false
            viewController = KKMyAffiliateViewController()
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
