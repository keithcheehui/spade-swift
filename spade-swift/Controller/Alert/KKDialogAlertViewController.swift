//
//  KKDialogAlertViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 27/06/2021.
//

import UIKit

class KKDialogAlertViewController: KKBaseViewController {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var leftButtonContainer: UIView!
    @IBOutlet weak var imgLeftButton: UIImageView!

    @IBOutlet weak var rightButtonContainer: UIView!
    @IBOutlet weak var imgRightButton: UIImageView!
    
    @IBOutlet weak var imgTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var containerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblMessageMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var lblMessageMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblMessageMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnContainerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var btnContainerHeight: NSLayoutConstraint!

    @IBOutlet weak var btnLeftWidth: NSLayoutConstraint!
    @IBOutlet weak var btnLeftMarginRight: NSLayoutConstraint!

    var alertType: DialogAlertType!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        showDialogType()
    }
    
    func initialLayout() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        imgTitleHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 25)
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 70)
        containerMarginBottom.constant = containerMarginTop.constant
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 140 : 160)
        containerMarginRight.constant = containerMarginLeft.constant
        lblMessageMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 30)
        lblMessageMarginRight.constant = lblMessageMarginLeft.constant
        lblMessageMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 40)
        btnContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        lblMessage.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 20))
        lblMessage.text = setupTextLabel()
    }
    
    func showDialogType() {
        switch alertType {
        case .Deposit:
            btnLeftWidth.constant = 0
            btnLeftMarginRight.constant = 0
            

        default:
            btnLeftWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 180 : 200)
            btnLeftMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        }
    }
    
    @IBAction func btnCloseDidPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLeftDidPressed() {
        functionForLeftButton()
    }
    
    @IBAction func btnRightDidPressed() {
        functionForRightButton()
    }
    
    func functionForLeftButton(){
        switch alertType {
        
        default:
            self.dismiss(animated: true, completion: nil)

        }
    }
    
    func functionForRightButton(){
        switch alertType {
        case .Logout:
            KKUtil.logOutUser()
            
        case .Deposit:
            break
        
        default: break
        }
    }
    
    func setupTextLabel() -> String {
        switch alertType {
        case .Logout:
            return KKUtil.languageSelectedStringForKey(key: "alert_logout")
            
        case .Deposit:
            return KKUtil.languageSelectedStringForKey(key: "alert_deposit")
        
        default: return ""
        }
    }
}
