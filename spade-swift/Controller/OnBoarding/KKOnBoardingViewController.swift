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
        buttonContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 80)
        buttonContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 60)
        buttonContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 100)
        buttonContainerMarginBottom.constant = buttonContainerMarginRight.constant
        btnLoginMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 50)
        btnLoginMarginRight.constant = btnLoginMarginLeft.constant
        
        
    }

}

