//
//  KKMessageListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 23/05/2021.
//

import Foundation
import UIKit
import KeychainSwift

class KKMessageListViewController: KKBaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var messageTableView: UITableView!

    var selectedMessageIndex = -1
    var inboxMessageArray: [KKInboxMessageDetails]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        self.getInboxAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageTableView.reloadData()
    }
    
    //MARK:- Layout Setup
    
    func initialLayout(){
        messageTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        messageTableView.register(KKMessageDetailsTableViewCell.self, forCellReuseIdentifier: CellIdentifier.messageTVCIdentifier)
        
        lblTitle.text = KKUtil.languageSelectedStringForKey(key: "message_title")
        lblTitle.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblTitle.textColor = UIColor.spade_white_FFFFFF
    }

    //MARK:- API Calls
    
    func getInboxAPI() {
        
        self.showAnimatedLoader()
        
        KKApiClient.getInbox().execute { systemMessageResponse in
            
            self.hideAnimatedLoader()
            self.inboxMessageArray = systemMessageResponse.results?.inboxMessages
            self.messageTableView.reloadData()

        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func updateInboxReadStatusAPI(messageId: Int) {
        KKApiClient.updateInboxReadStatus(msgId: messageId).execute { systemMessageResponse in
            self.inboxMessageArray[self.selectedMessageIndex].status = "Read"
            self.messageTableView.reloadData()
            self.checkifGotUnreadMessage()

        } onFailure: { errorMessage in
            self.messageTableView.reloadData()
        }
    }
    
    func checkifGotUnreadMessage() {
        if (inboxMessageArray.count > 0) {
            var gotUnread = false

            for inbox in inboxMessageArray {
                if inbox.status != "Read" {
                    gotUnread = true
                    break
                }
            }
            
            if KKUtil.isUserLogin() {
                if var userProfile = KKUtil.decodeUserProfileFromCache() {
                    userProfile.inboxUnreadMessages = gotUnread
                    KKUtil.encodeUserProfile(object: userProfile)
                }
            }
        }
    }
}

extension KKMessageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxMessageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.messageTVCIdentifier, for: indexPath) as? KKMessageDetailsTableViewCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (selectedMessageIndex == indexPath.row) {
            cell.setUpMessageDetails(messageDetails: inboxMessageArray[indexPath.row], isHidden: false, tableViewWidth: tableView.frame.size.width)
        } else {
            cell.setUpMessageDetails(messageDetails: inboxMessageArray[indexPath.row], isHidden: true, tableViewWidth: tableView.frame.size.width)
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
        
        if (selectedMessageIndex > -1) {
            if (inboxMessageArray[selectedMessageIndex].status != "Read") {
                updateInboxReadStatusAPI(messageId: inboxMessageArray[selectedMessageIndex].id!)
            }
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if (selectedMessageIndex == indexPath.row) {
            return KKMessageDetailsTableViewCell.calculateMessageDetailsHeight(messageDetails: inboxMessageArray[indexPath.row], isHidden: false, tableViewWidth: tableView.frame.size.width)
        } else {
            return KKMessageDetailsTableViewCell.calculateMessageDetailsHeight(messageDetails: inboxMessageArray[indexPath.row], isHidden: true, tableViewWidth: tableView.frame.size.width)
        }
    }
}
