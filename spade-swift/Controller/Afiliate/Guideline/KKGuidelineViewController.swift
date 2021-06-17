//
//  KKGuidelineViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 15/05/2021.
//

import Foundation
import UIKit

class KKGuidelineViewController: KKBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var guidelineTableView: UITableView!
    @IBOutlet weak var lblCommission: UILabel!
    
    @IBOutlet weak var topHeaderHeight: NSLayoutConstraint!
    @IBOutlet weak var btnCommissionTableMarginRight: NSLayoutConstraint!

    var guidelineArray: [KKGuidelineDetails]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topHeaderHeight.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 80 : 100)
        btnCommissionTableMarginRight.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 30 : 60)

        guidelineTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        guidelineTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        lblCommission.text = KKUtil.languageSelectedStringForKey(key: "affiliates_downline_commission")
        lblCommission.textColor = UIColor.spade_white_FFFFFF
        lblCommission.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        
        getGuidelinesList()
    }
    
    @IBAction func btnCommissionTableDidPressed() {
        
    }
    
    //MARK:- API Calls
    
    func getGuidelinesList() {
        
        self.showAnimatedLoader()
        
        KKApiClient.getAffiliateGuidelineContent().execute { GuidelineResponse in
            
            self.hideAnimatedLoader()
            self.guidelineArray = GuidelineResponse.results?.affiliate_guidelines
            self.guidelineTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(alertMessage: "Api Error. Currently api is updating")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return guidelineArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let imageView = UIImageView()
        imageView.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 20), y: 2, width: KKUtil.ConvertSizeByDensity(size: 26), height: KKUtil.ConvertSizeByDensity(size: 26))
        imageView.image = UIImage(named: "bg_numbering")

        let numberLabel = UILabel()
        numberLabel.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 20), y: 5, width: KKUtil.ConvertSizeByDensity(size: 26), height: KKUtil.ConvertSizeByDensity(size: 20))
        numberLabel.textColor = UIColor.black
        numberLabel.backgroundColor = UIColor.clear
        numberLabel.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        numberLabel.textAlignment = NSTextAlignment.center
        numberLabel.text = String(format: "%02d", section + 1)
        
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 60), y: 0, width: self.view.frame.size.width, height: KKUtil.ConvertSizeByDensity(size: 30))
        headerLabel.textColor = UIColor.white
        headerLabel.numberOfLines = 0
        headerLabel.backgroundColor = UIColor.clear
        headerLabel.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        headerLabel.text = guidelineArray[section].title

        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: KKUtil.ConvertSizeByDensity(size: 30))
        headerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        headerView.addSubview(imageView)
        headerView.addSubview(numberLabel)
        headerView.addSubview(headerLabel)

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return KKUtil.ConvertSizeByDensity(size: 30)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        let cellText = guidelineArray[indexPath.section].content
        cell.textLabel?.text = cellText
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))

        cell.selectionStyle = .none

        return cell
    }
}
