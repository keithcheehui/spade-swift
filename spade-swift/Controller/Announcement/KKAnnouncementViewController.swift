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
        announcementTableView.register(UINib(nibName: "KKAnnouncementTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.announcementTableCellIdentifier)

    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.announcementTableCellIdentifier, for: indexPath) as? KKAnnouncementTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 50)
    }
}
