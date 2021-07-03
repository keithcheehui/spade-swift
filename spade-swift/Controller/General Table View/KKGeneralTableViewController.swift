//
//  KKGeneralTableViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 18/06/2021.
//

import UIKit

class KKGeneralTableViewController: KKBaseViewController {

    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var groupsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var groupsCollectionMarginBottom: NSLayoutConstraint!

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var leftContainer: UIView!
    @IBOutlet weak var leftPickerTitle: UILabel!
    @IBOutlet weak var leftPickerValueView: UIView!
    @IBOutlet weak var leftPickerTxtValue: UITextField!
    
    @IBOutlet weak var rightContainer: UIView!
    @IBOutlet weak var rightPickerTitle: UILabel!
    @IBOutlet weak var rightPickerValueView: UIView!
    @IBOutlet weak var rightPickerTxtValue: UITextField!

    @IBOutlet weak var topContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerWidth: NSLayoutConstraint!

    @IBOutlet weak var contentTableView: UITableView!

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
    
    var tableViewType: TableViewType!
    var cashFlowArray: [KKUserCashFlowDetails]! = []
    var bettingRecordArray: [KKUserBettingHistoryDetails]! = []
    var withdrawHistoryArray: [KKHistoryDetails]! = []
    var depositHistoryArray: [KKHistoryDetails]! = []
    
    var tabGroupArray: [KKUserBettingGroupDetails]! = []
    var selectedTabItem = 0

    var leftTitle: String!
    var leftValue: String!
    var leftDropdownOptions: [PickerDetails] = []
    
    var rightTitle: String!
    var rightValue: String!
    var rightDropdownOptions: [PickerDetails] = []
    
    var selectedLeftItem: PickerDetails!
    var selectedRightItem: PickerDetails!
    
    var isLeft = false
    var isRight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLeftDropdownOptions()
        initialLayout()
        setUpContentTableView()
        updateTable()
        
        groupsCollectionView.register(UINib(nibName: "KKTabListItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.tabListItemCVCIdentifier)
        
        switch tableViewType {
        case .BettingRecord,
             .AccountDetails:
            initFlowLayout()
            
        default:
            groupsCollectionView.isHidden = true
            groupsCollectionViewHeight.constant = 0
            groupsCollectionMarginBottom.constant = 0
        }
    }

    func initFlowLayout(){
        groupsCollectionView.isHidden = false
        groupsCollectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        groupsCollectionMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 5)
        
        let size = KKUtil.ConvertSizeByDensity(size: 40)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: 5)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: size * 3, height: size)
        groupsCollectionView.collectionViewLayout = flowLayout
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
    
    func initialLayout() {
        pickerWidth.constant = KKUtil.ConvertSizeByDensity(size: 120)
        
        leftPickerValueView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        rightPickerValueView.backgroundColor = leftPickerValueView.backgroundColor
        
        leftPickerTitle.textColor = .spade_white_FFFFFF
        leftPickerTxtValue.textColor = leftPickerTitle.textColor
        rightPickerTitle.textColor = leftPickerTitle.textColor
        rightPickerTxtValue.textColor = leftPickerTitle.textColor
        
        leftPickerTitle.font = UIFont.systemFont(ofSize: 10)
        leftPickerTxtValue.font = leftPickerTitle.font
        rightPickerTitle.font = leftPickerTitle.font
        rightPickerTxtValue.font = leftPickerTitle.font
        
        leftPickerTxtValue.inputView = pickerView
        leftPickerTxtValue.inputAccessoryView = pickerToolBarView
        
        rightPickerTxtValue.inputView = pickerView
        rightPickerTxtValue.inputAccessoryView = pickerToolBarView

        switch tableViewType {
        
        case .BettingRecord:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_bet_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_game_platform")
            if (selectedRightItem == nil) {
                selectedRightItem = rightDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withRightPicker: true)
            
        case .AccountDetails:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withRightPicker: false)

        case .DepositHistory:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_withdraw_status")
            if (selectedRightItem == nil) {
                selectedRightItem = rightDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withRightPicker: true)

        case .WithdrawHistory:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_withdraw_status")
            if (selectedRightItem == nil) {
                selectedRightItem = rightDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withRightPicker: true)

        default:
            self.showTopContainer(shouldShow: false, withRightPicker: false)
        }
    }

    func showTopContainer(shouldShow: Bool, withRightPicker: Bool){
        if (shouldShow){
            topContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 35)
            topContainer.isHidden = false
            
            showDropdownOption(showRight: withRightPicker)
        } else {
            topContainerHeight.constant = 0
            topContainer.isHidden = true
        }
    }
    
    func getLeftDropdownOptions() {
        switch tableViewType {
            
            default:
                leftDropdownOptions = pickerTimeArray
        }
    }
    
    func showDropdownOption(showRight: Bool){
        rightContainer.isHidden = true
        
        leftPickerTitle.text = leftTitle
        leftPickerTxtValue.text = leftValue

        if (showRight){
            rightContainer.isHidden = false
            
            rightPickerTitle.text = rightTitle
            rightPickerTxtValue.text = rightValue
        }
    }
    
    
    func updateTable() {
        if (leftDropdownOptions.count > 0 && selectedLeftItem != nil) {
            leftPickerTxtValue.text = selectedLeftItem.name
        }
        if (rightDropdownOptions.count > 0 && selectedRightItem != nil) {
            rightPickerTxtValue.text = selectedRightItem.name
        }
        
        var tabId = ""
        switch tableViewType {
        case .AccountDetails:
            tabId = pickerCashflowArray[selectedTabItem].id
        case .BettingRecord:
            tabId = String(tabGroupArray[selectedTabItem].code ?? "")
        default:
            break;
        }
        
        if tableViewType == .BettingRecord {
            self.getUserBettingRecordAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id, tabItem: tabId)
        } else if tableViewType == .AccountDetails {
            self.getUserAccountDetailsAPI(leftPicker: selectedLeftItem.id, tabItem: tabId)
        } else if tableViewType == .WithdrawHistory {
            self.withdrawHistoryAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id)
        } else if tableViewType == .DepositHistory {
            self.depositHistoryAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id)
        }
    }
    
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
            return [depositHistoryDetails.trxTimestamp ?? "", String(depositHistoryDetails.transactionId ?? 0), depositHistoryDetails.amount ?? "", depositHistoryDetails.status ?? ""]

        case .WithdrawHistory:
            let withdrawHistoryDetails = withdrawHistoryArray[indexPath.row]
            return [withdrawHistoryDetails.trxTimestamp ?? "", String(withdrawHistoryDetails.transactionId ?? 0) , withdrawHistoryDetails.amount ?? "", withdrawHistoryDetails.status ?? ""]
            
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
    
    func withdrawHistoryAPI(leftPicker: String, rightPicker: String) {
        
        self.showAnimatedLoader()
        
        KKApiClient.withdrawHistory(filter: leftPicker, historyStatus: rightPicker).execute { withdrawHistoryResponse in
            
            self.hideAnimatedLoader()
            self.withdrawHistoryArray = withdrawHistoryResponse.results?.withdrawHistory
            self.contentTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func depositHistoryAPI(leftPicker: String, rightPicker: String) {
        
        self.showAnimatedLoader()
        
        KKApiClient.depositHistory(filter: leftPicker, historyStatus: rightPicker).execute { depositHistoryResponse in
            
            self.hideAnimatedLoader()
            self.depositHistoryArray = depositHistoryResponse.results?.depositHistory
            self.contentTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @objc
    override func didTapDone() {
        view.endEditing(true)
        pickerView.isHidden = true
        if selectedPickerItem == nil {
            return
        }
        
        if (isLeft && selectedPickerItem != nil) {
            selectedLeftItem = selectedPickerItem
        }
        
        if (isRight && selectedPickerItem != nil) {
            selectedRightItem = selectedPickerItem
        }
        
        updateTable()
    }
}

extension KKGeneralTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == rightPickerTxtValue {
            showPickerView(optionList: rightDropdownOptions)
            pickerTextField = textField
            isRight = true
            isLeft = false
        } else {
            showPickerView(optionList: leftDropdownOptions)
            pickerTextField = textField
            selectedLeftItem = selectedPickerItem
            isRight = false
            isLeft = true
        }
        
        //TODO: KEITH, add the subclass, and add disable copy paste pop up
        textField.tintColor = UIColor.clear
    }
}

extension KKGeneralTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tableViewType {
        case .AccountDetails:
            return pickerCashflowArray.count
        case .BettingRecord:
            return tabGroupArray.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.tabListItemCVCIdentifier, for: indexPath) as? KKTabListItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (indexPath.row == selectedTabItem) {
            cell.imgHover.isHidden = false
        } else {
            cell.imgHover.isHidden = true
        }
        
        switch tableViewType {
        case .AccountDetails:
            cell.lblTitle.text = pickerCashflowArray[indexPath.item].name
        default:
            cell.lblTitle.text = tabGroupArray[indexPath.item].name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTabItem = indexPath.item
        collectionView.reloadData()
        updateTable()
        
        return
    }
}

extension KKGeneralTableViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        } else {
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
