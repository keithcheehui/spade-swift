//
//  KKOnBoardingViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 21/04/2021.
//

import Foundation
import UIKit

class KKOnBoardingViewController: KKBaseViewController {

    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgFB: UIImageView!
    @IBOutlet weak var btnFB: UIButton!
    @IBOutlet weak var imgLogin: UIImageView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgRegister: UIImageView!
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var imgLogoWidth: NSLayoutConstraint!
    @IBOutlet weak var buttonContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var buttonContainerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var buttonContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var buttonContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var btnLoginMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var btnLoginMarginRight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }

    func initialLayout(){
        imgLogoWidth.constant = KKUtil.ConvertSizeByDensity(size: 480)
        buttonContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 20)
        buttonContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 50 : 45)
        buttonContainerMarginLeft.constant =  KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 120)
        buttonContainerMarginRight.constant = buttonContainerMarginLeft.constant
        btnLoginMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 20)
        btnLoginMarginRight.constant = btnLoginMarginLeft.constant
    }
    
    ///Button Actions
    @IBAction func btnFBDidPressed(){
        
    }
    
    @IBAction func btnLoginDidPressed(){
        self.present(KKLoginViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnRegisterDidPressed(){
        self.present(KKRegistrationViewController(), animated: false, completion: nil)
    }
}

