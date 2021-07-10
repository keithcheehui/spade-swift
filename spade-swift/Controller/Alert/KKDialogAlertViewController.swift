//
//  KKDialogAlertViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 27/06/2021.
//

import UIKit

class KKDialogAlertViewController: KKBaseViewController {

    @IBOutlet weak var lblMessageTitle: UILabel!
    @IBOutlet weak var lblMessageDesc: UILabel!
    @IBOutlet weak var leftButtonContainer: UIView!
    @IBOutlet weak var imgLeftButton: UIImageView!

    @IBOutlet weak var rightButtonContainer: UIView!
    @IBOutlet weak var imgRightButton: UIImageView!
    
    @IBOutlet weak var imgTitleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var imgTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var lblMessageMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var lblMessageMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblMessageMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnContainerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var btnContainerHeight: NSLayoutConstraint!

    @IBOutlet weak var btnLeftWidth: NSLayoutConstraint!
    @IBOutlet weak var btnLeftMarginRight: NSLayoutConstraint!

    var alertType: DialogAlertType!
    var transactionId: String!
    var message: String!
    var webViewController: KKWebViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        showDialogType()
    }
    
    func initialLayout() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerWidth.constant = KKUtil.isSmallerPhone() ? ScreenSize.maxLength * 0.65 : ScreenSize.maxLength * 0.5
        containerHeight.constant = KKUtil.isSmallerPhone() ? ScreenSize.minLength * 0.7 : ScreenSize.minLength * 0.65
        imgTitleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 15)
        imgTitleHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 25)
        lblMessageMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblMessageMarginRight.constant = lblMessageMarginLeft.constant
        lblMessageMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        lblMessageTitle.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 20))
        lblMessageTitle.text = setupTitleLabel()
        lblMessageDesc.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblMessageDesc.text = setupDescLabel()
    }
    
    func showDialogType() {
        switch alertType {
        case .Deposit,
             .Withdraw:
            btnLeftWidth.constant = 0
            btnLeftMarginRight.constant = 0
            imgRightButton.image = UIImage(named: "btn_ok")
        
        default:
            btnLeftWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 180 : 200)
            btnLeftMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 20)
            imgRightButton.image = UIImage(named: "btn_yes")
        }
    }
    
    @IBAction func btnCloseDidPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLeftDidPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRightDidPressed() {
        functionForRightButton()
    }
    
    func functionForRightButton(){
        switch alertType {
        case .Logout:
            KKUtil.logOutUser()
            
        case .ExitGame:
            webViewController.closeDialogAndPop()
        
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupTitleLabel() -> String {
        switch alertType {
        case .Logout:
            return KKUtil.languageSelectedStringForKey(key: "alert_logout")
            
        case .Deposit:
            return KKUtil.languageSelectedStringForKey(key: "alert_title_deposit")
            
        case .Withdraw:
            return KKUtil.languageSelectedStringForKey(key: "alert_title_withdraw")
        
        case .ExitGame:
            return KKUtil.languageSelectedStringForKey(key: "alert_close_page")

        default: return ""
        }
    }
    
    func setupDescLabel() -> String {
        switch alertType {
        case .Deposit:
            return message
//            return KKUtil.languageSelectedStringForKey(key: "alert_desc_deposit")

        case .Withdraw:
            return message
//            return KKUtil.languageSelectedStringForKey(key: "alert_desc_withdraw")

        default: return ""
        }
    }
}
