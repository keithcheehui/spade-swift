//
//  KKMessageListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 23/05/2021.
//

import Foundation
import UIKit

class KKMessageListViewController: KKBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var messageTableView: UITableView!

    let messageList = [{},{},{}]
    var selectedMessageIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        messageTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        messageTableView.register(UINib(nibName: "KKMessageTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.messageTVCIdentifier)
        
        lblTitle.text = KKUtil.languageSelectedStringForKey(key: "message_title")
        lblTitle.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblTitle.textColor = UIColor.spade_white_FFFFFF
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.messageTVCIdentifier, for: indexPath) as? KKMessageTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (selectedMessageIndex == indexPath.row) {
            cell.lblMsgContent.isHidden = false
            cell.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(180.0 * Double.pi / 180.0))
            //TODO: Keith: Calculate the msg content height, replace the 30 hard code
            cell.bottomLabelHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        } else {
            cell.lblMsgContent.isHidden = true
            cell.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(0.0 * Double.pi / 180.0))
            cell.bottomLabelHeight.constant = 0
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (selectedMessageIndex == indexPath.row) {
            selectedMessageIndex = -1
        } else {
            selectedMessageIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: Keith: Calculate the msg content height, replace the 80 hard code
        if (selectedMessageIndex == indexPath.row) {
            return KKUtil.ConvertSizeByDensity(size: 80)
        } else {
            return KKUtil.ConvertSizeByDensity(size: 50)
        }
    }
}
