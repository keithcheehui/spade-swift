//
//  KKAnnouncementViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 10/05/2021.
//

import Foundation
import UIKit

class KKAnnouncementViewController: KKBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var announcementTableView: UITableView!

    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!

    let announcementList = [{},{},{}]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        imgTitleHeight.constant = KKUtil.ConvertSizeByDensity(size: 45)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        
        announcementTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        announcementTableView.register(UINib(nibName: "KKAnnouncementTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.announcementTVCIdentifier)
        
        contentContainer.isHidden = true
        lblBack.text = KKUtil.languageSelectedStringForKey(key: "announcement_back")
        lblBack.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblBack.textColor = UIColor.spade_blue_5CB5DE
    }
    
    ///Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnBackDidPressed(){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        announcementTableView.isHidden = false
        contentContainer.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.announcementTVCIdentifier, for: indexPath) as? KKAnnouncementTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        announcementTableView.isHidden = true
        contentContainer.isHidden = false
        
        let vc: KKBaseViewController = KKAnnoucementContentViewController()
        vc.tableContentView = contentView
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 50)
    }
}
