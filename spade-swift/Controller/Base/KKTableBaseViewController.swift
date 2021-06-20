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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpContentTableView()
        
        if tableViewType == .BettingRecord {
            
            self.getUserBettingRecord()
        }
        else if tableViewType == .AccountDetails {
            
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
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    //MARK:- API Calls

    func getUserBettingRecord() {
        
        self.showAnimatedLoader()
        
        KKApiClient.getUserBettingRecord().execute { bettingHistoryResponse in
            
            self.hideAnimatedLoader()
            self.bettingRecordArray = bettingHistoryResponse.results?.betslips
            self.contentTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(alertMessage: errorMessage)
        }
    }
    
    //MARK:- Others
    
    func returnCellDetails(indexPath: IndexPath) -> [String] {
        
        if tableViewType == .BettingRecord {
            
            let bettingRecordDetails = bettingRecordArray[indexPath.row]
            return [bettingRecordDetails.trxTimestamp ?? "", bettingRecordDetails.refNo ?? "", bettingRecordDetails.gameName ?? "", bettingRecordDetails.stake ?? "", bettingRecordDetails.result ?? ""]
        }
        
        return []
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
        
            case .BettingRecord:
                return bettingRecordArray.count
                
            case .AccountDetails:
                return cashFlowArray.count
                
            default:
                return 0
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
