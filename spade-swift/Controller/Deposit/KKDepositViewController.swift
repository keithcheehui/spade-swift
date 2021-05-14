//
//  KKDepositViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKDepositViewController: KKBaseViewController {
    
    @IBOutlet weak var lblBankAccount: UILabel!
    @IBOutlet weak var lblArtificial: UILabel!
    @IBOutlet weak var imgHoverBankAccount: UIImageView!
    @IBOutlet weak var imgHoverArtificial: UIImageView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    
    enum viewType: Int {
        case bankAccount = 0
        case artificial = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.bankAccount.rawValue)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblBankAccount.text = KKUtil.languageSelectedStringForKey(key: "deposit_bank_account")
        lblArtificial.text = KKUtil.languageSelectedStringForKey(key: "deposit_artificial")
        
        lblBankAccount.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblArtificial.font = lblBankAccount.font
    }
    
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBankAccountDidPressed(){
        buttonHover(type: viewType.bankAccount.rawValue)
    }
    
    @IBAction func btnArtificialDidPressed(){
        self.navigationController?.pushViewController(KKSupportViewController(), animated: true)
    }

    func buttonHover(type: Int){
        imgHoverBankAccount.isHidden = false
        imgHoverArtificial.isHidden = true
        
        changeView(vc: KKDepositRequestViewController())
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
