//
//  KKMessageListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 23/05/2021.
//

import Foundation
import UIKit

class KKMessageListViewController: KKBaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var messageTableView: UITableView!

    let messageList = [{},{},{}]
    var selectedMessageIndex = -1
    var systemMessageArray: [KKSystemMessageDetails]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        self.getSystemMessageContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageTableView.reloadData()
    }
    
    //MARK:- Layout Setup
    
    func initialLayout(){
        messageTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        messageTableView.register(UINib(nibName: "KKMessageTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.messageTVCIdentifier)
        
        lblTitle.text = KKUtil.languageSelectedStringForKey(key: "message_title")
        lblTitle.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblTitle.textColor = UIColor.spade_white_FFFFFF
    }

    //MARK:- API Calls
    
    func getSystemMessageContent() {
        
        self.showAnimatedLoader()
        
        KKApiClient.getSystemMessages().execute { systemMessageResponse in
            
            self.hideAnimatedLoader()
            self.systemMessageArray = systemMessageResponse.results?.systemMessages
            self.messageTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(alertMessage: "Api Error. Currently api is updating")
        }

    }
}

extension KKMessageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systemMessageArray.count
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
            cell.bottomLabelHeight.constant = cell.setUpMessageDetails(messageDetails: systemMessageArray[indexPath.row], isHidden: false)
        } else {
            cell.lblMsgContent.isHidden = true
            cell.imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat(0.0 * Double.pi / 180.0))
            cell.bottomLabelHeight.constant = cell.setUpMessageDetails(messageDetails: systemMessageArray[indexPath.row], isHidden: true)
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
            return KKMessageTableCell.calculateMessageDetailsHeight(messageDetails: systemMessageArray[indexPath.row], isHidden: false)
        } else {
            return KKMessageTableCell.calculateMessageDetailsHeight(messageDetails: systemMessageArray[indexPath.row], isHidden: true)
        }
    }
}
