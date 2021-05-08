//
//  KKUserInfoViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 08/05/2021.
//

import Foundation
import UIKit

class KKUserInfoViewController: KKBaseViewController {
    
    @IBOutlet weak var levelSectionView: UIView!
    @IBOutlet weak var lblLevelSection: UILabel!
    @IBOutlet weak var lblCurrentMembership: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgCurrentRank: UIImageView!
    @IBOutlet weak var imgNextRank: UIImageView!
    @IBOutlet weak var rankProgressBar: UIProgressView!

    


    @IBOutlet weak var basicSectionView: UIView!
    @IBOutlet weak var lblBasicSection: UILabel!

    
    @IBOutlet weak var sectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sectionIconWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imgProfileWidth: NSLayoutConstraint!
    @IBOutlet weak var rankContainerViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        levelSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        basicSectionView.backgroundColor = UIColor(white: 0, alpha: 0.3)

        sectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        sectionIconWidth.constant = KKUtil.ConvertSizeByDensity(size: 12)
        
        imgProfileWidth.constant = KKUtil.ConvertSizeByDensity(size: 40)
        rankContainerViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        
        
        lblLevelSection.text = KKUtil.languageSelectedStringForKey(key: "user_info_level_privilege")
        lblBasicSection.text = KKUtil.languageSelectedStringForKey(key: "user_info_basic_information")
        
        lblLevelSection.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
        lblBasicSection.font = lblLevelSection.font
        
        
        lblCurrentMembership.text = KKUtil.languageSelectedStringForKey(key: "user_info_current_membership")
        
        lblCurrentMembership.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblAccountNumber.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblProgress.font = lblAccountNumber.font
        
    }
    
    func levelLayoutValue(){
        lblAccountNumber.text = "80808080"
        lblProgress.text = "RM100 / RM10,000"
    }
    
    
    ///Button Actions
    @IBAction func btnMyVipLevelDidPressed(){
        
    }
    
    
}
