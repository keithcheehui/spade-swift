//
//  KKBankListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKBankListViewController: KKBaseViewController {
    
    @IBOutlet weak var addContainer: UIView!
    @IBOutlet weak var lblAddBank: UILabel!
    @IBOutlet weak var addContainerHeight: NSLayoutConstraint!

    @IBOutlet weak var bankTableView: UITableView!

    var userBankList: [KKUserBankCards]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        getUserBankCardsAPI()
    }
    
    func initialLayout(){
        addContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 50)
        addContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        addContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        addContainer.layer.cornerRadius = 8
        
        lblAddBank.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblAddBank.text = KKUtil.languageSelectedStringForKey(key: "withdraw_add_bank")
        lblAddBank.textColor = .spade_white_FFFFFF
            
        bankTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        bankTableView.register(UINib(nibName: "KKBankTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.bankTVCIdentifier)
        self.bankTableView.isHidden = true
    }
    
    func changeAddBankView() {
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        
        let vc = KKAddBankViewController.init()
        vc.tableContentView = self.view
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(vc.view)
        self.addChild(vc)
    }
    
    func getUserBankCardsAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.getUserBankCards().execute { withdrawPageDataResponse in
            self.hideAnimatedLoader()
            self.userBankList = withdrawPageDataResponse.results?.userBankCards
            self.updateView()
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
            self.updateView()
        }
    }
    
    func updateView() {
        if (self.userBankList != nil && !self.userBankList.isEmpty) {
            self.bankTableView.isHidden = false
        } else {
            self.bankTableView.isHidden = true
        }
        self.bankTableView.reloadData()
    }
    
    @IBAction func btnAddDidPressed() {
        if (userBankList.count >= 2) {
            self.showAlertView(type: .Error, alertMessage: KKUtil.languageSelectedStringForKey(key: "error_bank_limit"))
            return
        }
        
        changeAddBankView()
    }
}

extension KKBankListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBankList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = KKUtil.languageSelectedStringForKey(key: "add_bank_all_bank_account")
        label.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        label.textColor = .spade_white_FFFFFF
        label.backgroundColor = .clear
        label.frame = CGRect(x: 22, y: 0, width: addContainer.frame.size.width, height: KKUtil.ConvertSizeByDensity(size: 20))
        
        return label
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = KKUtil.languageSelectedStringForKey(key: "add_bank_prompt")
        label.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        label.textColor = .spade_yellow_FFFF00
        label.backgroundColor = .clear
        label.frame = CGRect(x: 22, y: 10, width: addContainer.frame.size.width, height: KKUtil.ConvertSizeByDensity(size: 20))
        
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.bankTVCIdentifier, for: indexPath) as? KKBankTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        cell.imgSelected.isHidden = true
        cell.containerView.layer.borderWidth = 0
        cell.lblBankAccount.isHidden = false
        cell.lblAccountName.isHidden = false
        cell.lblAccountNameHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)

        cell.lblBankAccount.text = userBankList[indexPath.row].bankAccountNumber?.bankAccountMasked
        cell.lblAccountName.text = userBankList[indexPath.row].bankAccountName
        cell.imgBank.setUpImage(with: userBankList[indexPath.row].bank?.img)
        cell.lblBankName.text = userBankList[indexPath.row].bank?.name

        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 60)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 30)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 20)
    }
}
