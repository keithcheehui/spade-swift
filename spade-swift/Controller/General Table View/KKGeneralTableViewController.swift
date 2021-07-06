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
    
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var labelContainer: UIView!
    @IBOutlet weak var lblTotal: UILabel!

    @IBOutlet weak var topContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerWidth: NSLayoutConstraint!

    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var btnContainer: UIView!
    @IBOutlet weak var imgButton: UIImageView!
    @IBOutlet weak var btnNonGame: UIButton!
    @IBOutlet weak var btnContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var btnContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var btnContainerMarginBottom: NSLayoutConstraint!

    var downlineArray = [
        ["01293123", "jane111", "10.00", "100.00"],
        ["01293123", "jane122", "10.00", "100.00"],
        ["01293123", "jane123", "10.00", "100.00"],
        ["01293123", "jane222", "10.00", "100.00"],
        ["01293123", "jane345", "10.00", "100.00"]
    ]

    var turnoverArray = [
        ["2021-02-21", "jane111", "1000.00", "100.00"],
        ["2021-02-21", "jane122", "1000.00", "100.00"],
        ["2021-02-21", "jane123", "1000.00", "100.00"],
        ["2021-02-21", "jane222", "1000.00", "100.00"],
        ["2021-02-21", "jane345", "1000.00", "100.00"]
    ]
    
    var payoutArray = [
        ["2021-02-21", "100,000.00", "0.01", "2000.00"],
        ["2021-02-21", "100,000.00", "0.01", "2000.00"],
        ["2021-02-21", "100,000.00", "0.01", "2000.00"],
        ["2021-02-21", "100,000.00", "0.01", "2000.00"],
        ["2021-02-21", "100,000.00", "0.01", "2000.00"]
    ]
    
    var commissionTransArray = [
        ["2021-02-21", "9999386", "Payout", "1000.00"],
        ["2021-02-21", "9999386", "Payout", "1000.00"],
        ["2021-02-21", "9999386", "Payout", "1000.00"],
        ["2021-02-21", "9999386", "Payout", "1000.00"],
        ["2021-02-21", "9999386", "Payout", "1000.00"]
    ]
    
    var commissionTableArray = [
        ["1-50K", "0.05%"],
        ["50-80K", "0.10%"],
        ["80-200K", "0.15%"],
        ["200K-500K", "0.20%"],
        ["1-50K", "0.05%"]
    ]
    
    var nonCommissionGameArray = [
        ["918KISS", "Samurai"],
        ["Suncity2", "Shark"],
        ["AG Casino", "Blackjack"],
        ["Mega888", "Birds Animal"]
    ]
    
    var rebateDetailsArray = [
        ["2021-02-21", "KY", "10000", "0.01", "100.00"],
        ["2021-02-21", "AB", "10000", "0.01", "100.00"],
        ["2021-02-21", "KY", "10000", "0.01", "100.00"],
        ["2021-02-21", "AB", "10000", "0.01", "100.00"],
    ]
    
    var tableViewType: TableViewType!
    var cashFlowArray: [KKUserCashFlowDetails]! = []
    var bettingRecordArray: [KKUserBettingHistoryDetails]! = []
    var withdrawHistoryArray: [KKHistoryDetails]! = []
    var depositHistoryArray: [KKHistoryDetails]! = []

    var tabGroupArray: [KKUserBettingGroupDetails]! = []
    var rebateTableArray: [KKRebateTableRebateTable]! = []
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
        setupTableType()
        setUpContentTableView()
        updateTable()
        
        groupsCollectionView.register(UINib(nibName: "KKTabListItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.tabListItemCVCIdentifier)
        
        switch tableViewType {
        case .BettingRecord,
//             .AccountDetails,
             .AffiliateCommTable,
             .RebatePayout,
             .RebateTable:
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
        pickerWidth.constant = KKUtil.ConvertSizeByDensity(size: 140)
        
        leftPickerValueView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        rightPickerValueView.backgroundColor = leftPickerValueView.backgroundColor
        
        leftPickerTitle.textColor = .spade_white_FFFFFF
        leftPickerTxtValue.textColor = leftPickerTitle.textColor
        rightPickerTitle.textColor = leftPickerTitle.textColor
        rightPickerTxtValue.textColor = leftPickerTitle.textColor
        
        leftPickerTitle.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        leftPickerTxtValue.font = leftPickerTitle.font
        rightPickerTitle.font = leftPickerTitle.font
        rightPickerTxtValue.font = leftPickerTitle.font
        
        leftPickerTxtValue.inputView = pickerView
        leftPickerTxtValue.inputAccessoryView = pickerToolBarView
        
        rightPickerTxtValue.inputView = pickerView
        rightPickerTxtValue.inputAccessoryView = pickerToolBarView

        leftPickerValueView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        leftPickerValueView.layer.masksToBounds = true
        leftPickerValueView.clipsToBounds = true
        rightPickerValueView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 4)
        rightPickerValueView.layer.masksToBounds = true
        rightPickerValueView.clipsToBounds = true
        
        searchContainer.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        searchContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        txtSearch.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "affiliates_search_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtSearch.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))

        labelContainer.backgroundColor = .clear
        lblTotal.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblTotal.text = String(format: KKUtil.languageSelectedStringForKey(key: "affiliates_total_comm"), "RM", "6000.00")
    }
    
    func setupTableType() {
        btnContainer.isHidden = true
        btnContainerHeight.constant = 0
        btnContainerMarginTop.constant = 0
        btnContainerMarginBottom.constant = btnContainerMarginTop.constant
   
        switch tableViewType {
        
        case .BettingRecord:
//            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_bet_time")
//            if (selectedLeftItem == nil) {
//                selectedLeftItem = leftDropdownOptions[0]
//            }
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_game_platform")
            if (selectedRightItem == nil) {
                selectedRightItem = rightDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withLeftPicker: false, withRightPicker: true)
            
        case .AccountDetails:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withLeftPicker: true)

        case .DepositHistory:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_withdraw_status")
            if (selectedRightItem == nil) {
                selectedRightItem = rightDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withLeftPicker: true, withRightPicker: true)

        case .WithdrawHistory:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_withdraw_status")
            if (selectedRightItem == nil) {
                selectedRightItem = rightDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withLeftPicker: true, withRightPicker: true)
            
        case .AffiliateDownline:
            self.showTopContainer(shouldShow: true, withSearchBar: true)
            
        case .AffiliateTurnover:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
                        
            self.showTopContainer(shouldShow: true, withLeftPicker: true, withSearchBar: true)

        case .AffiliatePayout,
             .RebatePayout:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withLeftPicker: true, withLabel: true)
            
        case .AffiliateCommTrans,
             .RebateTrans:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            if (selectedLeftItem == nil) {
                selectedLeftItem = leftDropdownOptions[0]
            }
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_affiliate_type")
            if (selectedRightItem == nil) {
                selectedRightItem = rightDropdownOptions[0]
            }
            
            self.showTopContainer(shouldShow: true, withLeftPicker: true, withRightPicker: true)
            
        case .AffiliateCommTable:
            self.showTopContainer(shouldShow: false)
            self.showButtonContainer(buttonType: .NonCommGame)
            
        case .RebateTable:
            self.showTopContainer(shouldShow: false)
            self.showButtonContainer(buttonType: .NonRebateGame)
            
        default:
            self.showTopContainer(shouldShow: false)
        }
    }

    func showTopContainer(shouldShow: Bool, withLeftPicker: Bool = false, withRightPicker: Bool = false, withSearchBar: Bool = false, withLabel: Bool = false){
        if (shouldShow){
            topContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 35)
            topContainer.isHidden = false
            
            leftContainer.isHidden = true
            rightContainer.isHidden = true
            searchContainer.isHidden = true
            labelContainer.isHidden = true

            if withLeftPicker {
                leftContainer.isHidden = false
                leftPickerTitle.text = leftTitle
                leftPickerTxtValue.text = leftValue
            }
            if withRightPicker {
                rightContainer.isHidden = false
                rightPickerTitle.text = rightTitle
                rightPickerTxtValue.text = rightValue
            }
            if withSearchBar {
                searchContainer.isHidden = false
            }
            if withLabel {
                labelContainer.isHidden = false
            }
        } else {
            topContainerHeight.constant = 0
            topContainer.isHidden = true
        }
    }
    
    func showButtonContainer(buttonType: PopupTableViewType?) {
        btnContainer.isHidden = false
        btnContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        btnContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 20)
        btnContainerMarginBottom.constant = btnContainerMarginTop.constant
        
        if (buttonType == .NonCommGame) {
            imgButton.image = UIImage(named: "btn_non_comm")
            btnNonGame.addTarget(self, action: #selector(btnNonCommGameDidPressed), for: .touchUpInside)
        } else {
            imgButton.image = UIImage(named: "btn_non_rebate")
            btnNonGame.addTarget(self, action: #selector(btnNonRebateGameDidPressed), for: .touchUpInside)
        }
    }
    
    func getLeftDropdownOptions() {
        switch tableViewType {
            
            default:
                leftDropdownOptions = pickerTimeArray
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
//        case .AccountDetails:
//            tabId = pickerCashflowArray[selectedTabItem].id
        case .RebateTable:
            tabId = String(rebateTableArray[selectedTabItem].groupId ?? -1)
            
        case .BettingRecord,
             .RebatePayout:
            tabId = String(tabGroupArray[selectedTabItem].code ?? "")
        default:
            break;
        }
        
        if tableViewType == .BettingRecord {
            self.getUserBettingRecordAPI(rightPicker: selectedRightItem.id, tabItem: tabId)
        } else if tableViewType == .AccountDetails {
            self.getUserAccountDetailsAPI(leftPicker: selectedLeftItem.id)
        } else if tableViewType == .WithdrawHistory {
            self.withdrawHistoryAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id)
        } else if tableViewType == .DepositHistory {
            self.depositHistoryAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id)
        } else if tableViewType == .RebateTable {
            contentTableView.reloadData()
        }
    }
    
    func returnCellDetails(indexPath: IndexPath) -> [String] {
        
        switch tableViewType {
        
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
            
        case .AffiliateDownline:
            return self.downlineArray[indexPath.row]
        
        case .AffiliateTurnover:
            return turnoverArray[indexPath.row]
        
        case .AffiliatePayout:
            return payoutArray[indexPath.row]
            
        case .AffiliateCommTrans:
            return commissionTableArray[indexPath.row]

        case .AffiliateCommTable:
            return commissionTableArray[indexPath.row]
            
        case .RebatePayout:
            return payoutArray[indexPath.row]
            
        case .RebateTrans:
            return commissionTransArray[indexPath.row]
            
        case .RebateTable:
            let rebateRates = rebateTableArray[selectedTabItem].rebateRates?[indexPath.row]
            return [rebateRates?.rate ?? "", rebateRates?.validStake ?? ""]

        default:
            return []
        }
    }
    
    @IBAction func btnSearchDidPressed() {
        
    }
    
    @objc func btnNonCommGameDidPressed() {
        presentPopupTableView(popupTableViewType: .NonCommGame)
    }
    
    @objc func btnNonRebateGameDidPressed() {
        let excludedRebateProducts = rebateTableArray[selectedTabItem].excludedProducts
        
        let vc = KKGeneralPopUpTableViewController.init()
        vc.popupTableViewType = .NonRebateGame
        vc.excludedRebateProducts = excludedRebateProducts
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func btnRebateDetailDidPressed() {
        presentPopupTableView(popupTableViewType: .RebateDetail)
    }
    
    func presentPopupTableView(popupTableViewType: PopupTableViewType) {
        let vc = KKGeneralPopUpTableViewController.init()
        vc.popupTableViewType = popupTableViewType
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK:- API Calls

    func getUserBettingRecordAPI(rightPicker: String, tabItem: String)   {
        
        self.showAnimatedLoader()
        
        KKApiClient.getUserBettingRecord(platformCode: rightPicker, groupCode: tabItem).execute { bettingHistoryResponse in
            
            self.hideAnimatedLoader()
            self.bettingRecordArray = bettingHistoryResponse.results?.betslips
            self.contentTableView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func getUserAccountDetailsAPI(leftPicker: String) {
        
        self.showAnimatedLoader()
        
        KKApiClient.getUserAccountDetails(filter: leftPicker).execute { cashFlowResponse in
            
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
//        case .AccountDetails:
//            return pickerCashflowArray.count
        case .RebateTable:
            return rebateTableArray.count
        
        case .BettingRecord,
             .AffiliateCommTable,
             .RebatePayout:
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
//        case .AccountDetails:
//            cell.lblTitle.text = pickerCashflowArray[indexPath.item].name
        case .RebateTable:
            cell.lblTitle.text = rebateTableArray[indexPath.item].name ?? ""
        
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
        
        case .BettingRecord:
            return bettingRecordArray.count
            
        case .AccountDetails:
            return cashFlowArray.count
            
        case .DepositHistory:
            return depositHistoryArray.count
            
        case .WithdrawHistory:
            return withdrawHistoryArray.count
            
        case .AffiliateDownline:
            return downlineArray.count
            
        case .AffiliateTurnover:
            return turnoverArray.count
            
        case .AffiliatePayout:
            return payoutArray.count
            
        case .AffiliateCommTrans:
            return commissionTransArray.count
            
        case .AffiliateCommTable:
            return commissionTableArray.count
            
        case .RebatePayout:
            return payoutArray.count
            
        case .RebateTrans:
            return commissionTransArray.count
            
        case .RebateTable:
            return rebateTableArray[selectedTabItem].rebateRates?.count ?? 0
            
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
        cell.setUpCellDetails(width: tableView.frame.size.width, content: cellDetails)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellDetails = self.returnCellDetails(indexPath: indexPath)
        return KKGeneralTableViewCell.calculateCellDetailsHeight(width: tableView.frame.size.width, content: cellDetails)
    }
}
