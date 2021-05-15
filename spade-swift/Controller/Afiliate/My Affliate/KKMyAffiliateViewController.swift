//
//  KKMyAffiliateViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 11/05/2021.
//

import Foundation
import UIKit

class KKMyAffiliateViewController: KKBaseViewController {
    
    @IBOutlet weak var lblMyID: UILabel!
    @IBOutlet weak var lblMyIDView: UIView!
    @IBOutlet weak var lblMyIDValue: UILabel!
    
    @IBOutlet weak var lblReferrerID: UILabel!
    @IBOutlet weak var lblReferrerIDView: UIView!
    @IBOutlet weak var lblReferrerIDValue: UILabel!
    
    @IBOutlet weak var lblMemberCount: UILabel!
    @IBOutlet weak var lblMemberCountView: UIView!
    @IBOutlet weak var lblMemberCountValue: UILabel!
    
    @IBOutlet weak var lblTurnover: UILabel!
    @IBOutlet weak var lblTurnoverView: UIView!
    @IBOutlet weak var lblTurnoverValue: UILabel!
    
    @IBOutlet weak var lblTodayCommission: UILabel!
    @IBOutlet weak var lblTodayCommissionView: UIView!
    @IBOutlet weak var lblTodayCommissionValue: UILabel!
    
    @IBOutlet weak var lblYesterdayCommission: UILabel!
    @IBOutlet weak var lblYesterdayCommissionView: UIView!
    @IBOutlet weak var lblYesterdayCommissionValue: UILabel!
    
    @IBOutlet weak var lblDownline: UILabel!
    @IBOutlet weak var lblDownlineView: UIView!
    @IBOutlet weak var lblDownlineValue: UILabel!
    
    @IBOutlet weak var qrCodeContainer: UIView!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var lblSaveImage: UILabel!
    @IBOutlet weak var urlView: UIView!
    @IBOutlet weak var lblURL: UILabel!
    @IBOutlet weak var lblCopy: UILabel!
    
    @IBOutlet weak var totalCommissionContainer: UIView!
    @IBOutlet weak var lblTitleTotalCommission: UILabel!
    @IBOutlet weak var lblTotalCommisionView: UIView!
    @IBOutlet weak var lblTotalCommisionValue: UILabel!
    
    @IBOutlet weak var availableCommissionContainer: UIView!
    @IBOutlet weak var lblTitleAvailableCommision: UILabel!
    @IBOutlet weak var lblAvailableCommissionView: UIView!
    @IBOutlet weak var lblAvailableCommissionValue: UILabel!
    
    @IBOutlet weak var shareRewardContainer: UIView!
    @IBOutlet weak var lblTitleShareReward: UILabel!
    @IBOutlet weak var lblShareRewardView: UIView!
    @IBOutlet weak var lblShareRewardValue: UILabel!
    
    
    @IBOutlet weak var myIDViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    @IBOutlet weak var iconMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var iconMarginRight: NSLayoutConstraint!
    @IBOutlet weak var btnCollectHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        myIDViewHeight.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 18 : 20))
        titleContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        iconWidth.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 30 : 35))
        btnCollectHeight.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 25 : 30))
        iconMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 30)
        iconMarginRight.constant = iconMarginLeft.constant
        btnCollectHeight.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 25))

        lblMyIDView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        lblReferrerIDView.backgroundColor = lblMyIDView.backgroundColor
        lblMemberCountView.backgroundColor = lblMyIDView.backgroundColor
        lblTurnoverView.backgroundColor = lblMyIDView.backgroundColor
        lblTodayCommissionView.backgroundColor = lblMyIDView.backgroundColor
        lblYesterdayCommissionView.backgroundColor = lblMyIDView.backgroundColor
        lblDownlineView.backgroundColor = lblMyIDView.backgroundColor
        urlView.backgroundColor = lblMyIDView.backgroundColor
        totalCommissionContainer.backgroundColor = lblMyIDView.backgroundColor
        lblTotalCommisionView.backgroundColor = lblMyIDView.backgroundColor
        availableCommissionContainer.backgroundColor = lblMyIDView.backgroundColor
        lblAvailableCommissionView.backgroundColor = lblMyIDView.backgroundColor
        shareRewardContainer.backgroundColor = lblMyIDView.backgroundColor
        lblShareRewardView.backgroundColor = lblMyIDView.backgroundColor

        lblMyIDView.layer.cornerRadius = 4
        lblReferrerIDView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblMemberCountView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblTurnoverView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblTodayCommissionView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblYesterdayCommissionView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblDownlineView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        urlView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblTotalCommisionView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblAvailableCommissionView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        lblShareRewardView.layer.cornerRadius = lblMyIDView.layer.cornerRadius
        qrCodeContainer.layer.cornerRadius = 8

        lblMyID.text = KKUtil.languageSelectedStringForKey(key: "my_affi_my_id")
        lblReferrerID.text = KKUtil.languageSelectedStringForKey(key: "my_affi_referrer_id")
        lblMemberCount.text = KKUtil.languageSelectedStringForKey(key: "my_affi_member_count")
        lblTurnover.text = KKUtil.languageSelectedStringForKey(key: "my_affi_turnover")
        lblTodayCommission.text = KKUtil.languageSelectedStringForKey(key: "my_affi_today_com")
        lblYesterdayCommission.text = KKUtil.languageSelectedStringForKey(key: "my_affi_yesterday_com")
        lblDownline.text = KKUtil.languageSelectedStringForKey(key: "my_affi_downline")
        lblSaveImage.text = KKUtil.languageSelectedStringForKey(key: "my_affi_save")
        lblCopy.text = KKUtil.languageSelectedStringForKey(key: "my_affi_copy")
        lblTitleTotalCommission.text = KKUtil.languageSelectedStringForKey(key: "my_affi_total_com")
        lblTitleAvailableCommision.text = KKUtil.languageSelectedStringForKey(key: "my_affi_available_com")
        lblTitleShareReward.text = KKUtil.languageSelectedStringForKey(key: "my_affi_share_reward")
        
        lblMyID.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 8 : 11))
        lblMyIDValue.font = lblMyID.font
        lblReferrerID.font = lblMyID.font
        lblReferrerIDValue.font = lblMyID.font
        lblMemberCount.font = lblMyID.font
        lblMemberCountValue.font = lblMyID.font
        lblTurnover.font = lblMyID.font
        lblTurnoverValue.font = lblMyID.font
        lblTodayCommission.font = lblMyID.font
        lblTodayCommissionValue.font = lblMyID.font
        lblYesterdayCommission.font = lblMyID.font
        lblYesterdayCommissionValue.font = lblMyID.font
        lblDownline.font = lblMyID.font
        lblDownlineValue.font = lblMyID.font
        lblSaveImage.font = lblMyID.font
        lblURL.font = lblMyID.font
        lblCopy.font = lblMyID.font
        lblTotalCommisionValue.font = lblMyID.font
        lblAvailableCommissionValue.font = lblMyID.font
        lblShareRewardValue.font = lblMyID.font
        lblTitleTotalCommission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 10 : 12))
        lblTitleAvailableCommision.font = lblTitleTotalCommission.font
        lblTitleShareReward.font = lblTitleTotalCommission.font
        
        lblMyID.textColor = UIColor.spade_grey_B3C0E0
        lblReferrerID.textColor = lblMyID.textColor
        lblMemberCount.textColor = lblMyID.textColor
        lblTurnover.textColor = lblMyID.textColor
        lblTodayCommission.textColor = lblMyID.textColor
        lblYesterdayCommission.textColor = lblMyID.textColor
        lblDownline.textColor = lblMyID.textColor
        lblTitleTotalCommission.textColor = lblMyID.textColor
        lblTitleAvailableCommision.textColor = lblMyID.textColor
        lblTitleShareReward.textColor = lblMyID.textColor
        
        lblMyIDValue.textColor = UIColor.spade_white_FFFFFF
        lblReferrerIDValue.textColor = lblMyIDValue.textColor
        lblMemberCountValue.textColor = lblMyIDValue.textColor
        lblTurnoverValue.textColor = lblMyIDValue.textColor
        lblTodayCommissionValue.textColor = lblMyIDValue.textColor
        lblYesterdayCommissionValue.textColor = lblMyIDValue.textColor
        lblDownlineValue.textColor = lblMyIDValue.textColor
        lblURL.textColor = lblMyIDValue.textColor
        lblCopy.textColor = lblMyIDValue.textColor
        lblTotalCommisionValue.textColor = lblMyIDValue.textColor
        lblAvailableCommissionValue.textColor = lblMyIDValue.textColor
        lblShareRewardValue.textColor = lblMyIDValue.textColor
        
        lblSaveImage.textColor = UIColor.spade_black_000000
    }
    
    ///Button Actions
    @IBAction func btnRefreshDidPressed(){

    }
    
    @IBAction func btnCommissionTransactionDidPressed(){

    }
    
    @IBAction func btnCommissionTableDidPressed(){

    }

    @IBAction func btnSaveQRDidPressed(){

    }
    
    @IBAction func btnCopyURLDidPressed(){

    }
    
    @IBAction func btnCollectCommissionDidPressed(){
        self.present(KKWithdrawCommissionViewController(), animated: false, completion: nil)
    }
    
    @IBAction func btnCollectRewardDidPressed(){

    }
}
