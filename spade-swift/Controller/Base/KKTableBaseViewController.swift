//
//  KKTableBaseViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/06/2021.
//

import UIKit

class KKTableBaseViewController: KKBaseViewController {
    
    @IBOutlet weak var contentTableView: UITableView!
    
    var tableViewType: TableViewType!
    var cashFlowArray: [KKUserCashFlowDetails]! = []
    var bettingRecordArray: [KKUserBettingHistoryDetails]! = []
    var withdrawHistoryArray: [KKWithdrawHistoryDetails]! = []
    var depositHistoryArray: [KKDepositHistoryDetails]! = []
    var selectedTabItem: String!

    var commissionTableArray = [
        ["Bronze", "100-100K", "(RM 0.2+) 0.2%"],
        ["Silver", "100K-500K", "(RM 300+) 0.3%"],
        ["Gold", "500-1000K", "(RM 2000+) 0.4%"],
        ["Platinum", "1000K+", "(RM 5000+) 0.5%"]
    ]
    
    var manualRebateArray = [
        ["P2P Game", "0.00", "0.00", "0.00"],
        ["Slots", "0.00", "0.00", "0.00"],
        ["Live Casino", "0.00", "0.00", "0.00"],
        ["Sports", "0.00", "0.00", "0.00"],
        ["Fishing", "0.00", "0.00", "0.00"]
    ]
    
    var rebateRecordArray = [
        ["2021-02-12 10:32:33", "0.00", "0.00", "-"],
        ["2021-02-12 10:55:33", "0.00", "0.00", "-"]
    ]
    
    var rebateRatioArray = [
        ["CQ9 Poker", "0.00", "0.00", "0.00"],
        ["KY Poker", "0.00", "0.00", "0.00"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpContentTableView()
        
        if tableViewType == .BettingRecord {
            getUserBettingRecordAPI(leftPicker: "", rightPicker: "", tabItem: selectedTabItem)
        } else if tableViewType == .AccountDetails {
            getUserAccountDetailsAPI(leftPicker: "", tabItem: selectedTabItem)
        } else if tableViewType == .WithdrawHistory {
            withdrawHistoryAPI(leftPicker: "")
        }
    }
    
    func setUpContentTableView() {
        
        contentTableView.register(KKGeneralHeaderView.self, forHeaderFooterViewReuseIdentifier: CellIdentifier.generalHeaderViewIdentifier)
        contentTableView.register(KKGeneralTableViewCell.self, forCellReuseIdentifier: CellIdentifier.generalItemCellIdentifier)
        contentTableView.backgroundColor = .clear
        contentTableView.showsVerticalScrollIndicator = false
        contentTableView.estimatedRowHeight = CGFloat(0)
        contentTableView.estimatedSectionHeaderHeight = CGFloat(0)
        contentTableView.estimatedSectionFooterHeight = CGFloat(0)
        contentTableView.separatorStyle = .none
        contentTableView.clipsToBounds = true
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    //MARK:- Others
    
    func returnCellDetails(indexPath: IndexPath) -> [String] {
        
        switch tableViewType {
        
        case .AffliateDownline:
            return ["873524213", "james012", "10.00", "100.00"]
            
        case .AffliateTurnover:
            return ["2021-02-23", "james012", "1000.00", "100.00"]
            
        case .CommissionTransaction:
            return ["2021-02-21", "", "100.00"]
            
        case .ComissionTable:
            return commissionTableArray[indexPath.row]
            
        case .ManualRebate:
            return manualRebateArray[indexPath.row]
            
        case .RebateRecord:
            return rebateRecordArray[indexPath.row]
            
        case .RebateRatio:
            return rebateRatioArray[indexPath.row]
            
        case .BettingRecord:
            let bettingRecordDetails = bettingRecordArray[indexPath.row]
            return [bettingRecordDetails.trxTimestamp ?? "", bettingRecordDetails.refNo ?? "", bettingRecordDetails.gameName ?? "", bettingRecordDetails.stake ?? "", bettingRecordDetails.result ?? ""]
            
        case .AccountDetails:
            let cashFlowDetails = cashFlowArray[indexPath.row]
            return [cashFlowDetails.trxTimestamp ?? "", cashFlowDetails.type ?? "", cashFlowDetails.type!.contains("Deposit") ? cashFlowDetails.amount ?? "" : "", cashFlowDetails.type!.contains("Withdrawal") ? cashFlowDetails.amount ?? "" : "", "\(cashFlowDetails.balance ?? 0)"]
            
        case .DepositHistory:
            let depositHistoryDetails = depositHistoryArray[indexPath.row]
            return [depositHistoryDetails.trxTimestamp ?? "", depositHistoryDetails.amount ?? "", depositHistoryDetails.paymentMethod ?? "", depositHistoryDetails.status ?? "", ""]
            
        case .WithdrawHistory:
            let withdrawHistoryDetails = withdrawHistoryArray[indexPath.row]
            return [withdrawHistoryDetails.trxTimestamp ?? "", withdrawHistoryDetails.withdrawCode ?? "", withdrawHistoryDetails.amount ?? "", withdrawHistoryDetails.withdrawalMethod ?? "", withdrawHistoryDetails.status ?? ""]
            
        default:
            return []
        }
    }
    
    //MARK:- API Calls

    func getUserBettingRecordAPI(leftPicker: String, rightPicker: String, tabItem: String)   {
        
        self.showAnimatedLoader()
        
        KKApiClient.getUserBettingRecord(filter: leftPicker, code: rightPicker).execute { bettingHistoryResponse in
            
            self.hideAnimatedLoader()
            self.bettingRecordArray = bettingHistoryResponse.results?.betslips
            self.contentTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func getUserAccountDetailsAPI(leftPicker: String, tabItem: String) {
        
        self.showAnimatedLoader()
        
        KKApiClient.getUserAccountDetails(filter: leftPicker, tabItem: tabItem).execute { cashFlowResponse in
            
            self.hideAnimatedLoader()
            self.cashFlowArray = cashFlowResponse.results?.cashflows
            self.contentTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func withdrawHistoryAPI(leftPicker: String) {
        
        self.showAnimatedLoader()
        
        KKApiClient.withdrawHistory(historyStatus: leftPicker).execute { withdrawHistoryResponse in
            
            self.hideAnimatedLoader()
            self.withdrawHistoryArray = withdrawHistoryResponse.results?.withdrawHistory
            self.contentTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
}

extension KKTableBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellIdentifier.generalHeaderViewIdentifier) as? KKGeneralHeaderView
        else {
            fatalError("dequeueReusableHeaderFooterView failed while casting")
        }
        
        headerView.setUpHeaderView(width: tableView.frame.size.width, type: tableViewType)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return KKGeneralHeaderView.calculateHeaderViewHeight()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        return CGFloat(0.01)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableViewType {
        
        case .ComissionTable:
            return commissionTableArray.count
            
        case .ManualRebate:
            return manualRebateArray.count
            
        case .RebateRecord:
            return rebateRecordArray.count
            
        case .RebateRatio:
            return rebateRatioArray.count
        
        case .BettingRecord:
            return bettingRecordArray.count
            
        case .AccountDetails:
            return cashFlowArray.count
            
        case .DepositHistory:
            return depositHistoryArray.count
            
        case .WithdrawHistory:
            return withdrawHistoryArray.count
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.generalItemCellIdentifier, for: indexPath) as? KKGeneralTableViewCell
        else {
            fatalError("dequeueReusableCell failed while casting")
        }

        if indexPath.row % 2 == 1 {
            
            cell.cellView.backgroundColor = .spade_blue_4850C6
        }
        else
        {
            cell.cellView.backgroundColor = .clear
        }
        
        let cellDetails = self.returnCellDetails(indexPath: indexPath)
        cell.setUpCellDetails(width: tableView.frame.size.width, content: cellDetails, type: tableViewType)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return KKGeneralTableViewCell.calculateCellDetailsHeight()
    }
}
