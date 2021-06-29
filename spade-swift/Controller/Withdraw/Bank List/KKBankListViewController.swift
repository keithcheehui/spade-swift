//
//  KKBankListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKBankListViewController: KKBaseViewController {
    
    @IBOutlet weak var bankTableView: UITableView!

    var userBankList: [KKWithdrawBankDetails]! = []
    var bankItemList: [KKWithdrawBankNames]! = []
    var bankListOptions: [PickerDetails]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        getBankListAPI()
    }
    
    func initialLayout(){
        bankTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        bankTableView.register(UINib(nibName: "KKBankTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.bankTVCIdentifier)
    }
    
    func changeAddBankView() {
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        
        let vc = KKAddBankViewController.init()
        vc.tableContentView = self.view
        vc.bankItemList = bankListOptions
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(vc.view)
        self.addChild(vc)
    }
    
    func getBankListAPI() {
        self.showAnimatedLoader()
        
        KKApiClient.getMemberWithdrawBankAccount().execute { withdrawBankResponse in
            self.hideAnimatedLoader()
            self.userBankList = withdrawBankResponse.results?.userBanks
            self.bankItemList = withdrawBankResponse.results?.bankNames
            
            if (self.bankItemList.count > 0) {
                for bank in self.bankItemList {
                    var bankDetail = PickerDetails()
                    bankDetail.id = String(bank.id ?? -1)
                    bankDetail.name = bank.name ?? ""
                    
                    self.bankListOptions.append(bankDetail)
                }
            }
            
            self.bankTableView.reloadData()
            
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
}

extension KKBankListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBankList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.bankTVCIdentifier, for: indexPath) as? KKBankTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        cell.imgSelected.isHidden = true

        if (indexPath.row == 0) {
            cell.containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            cell.lblBankName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))

            cell.lblBankName.text = KKUtil.languageSelectedStringForKey(key: "withdraw_add_bank")
            cell.lblBankAccount.isHidden = true
            cell.imgBank.image = UIImage(named: "ic_add")
        } else {
            cell.containerView.layer.borderWidth = 0
 
            if let bankAccNumber = userBankList[indexPath.row - 1].bankAccountNumber {
                if bankAccNumber.isEmpty {
                    cell.lblBankAccount.text = ""
                } else {
                    cell.lblBankAccount.text = userBankList[indexPath.row - 1].bankAccountNumber!.bankAccountMasked
                }
            }
            
            for bankItem in bankItemList {
                if bankItem.id == userBankList[indexPath.row - 1].bankId {
                    cell.imgBank.setUpImage(with: bankItem.img)
                }
            }
            
            cell.lblBankName.text = userBankList[indexPath.row - 1].bankName
            cell.lblBankAccount.isHidden = false
        }
        
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            changeAddBankView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 45)
    }
}
