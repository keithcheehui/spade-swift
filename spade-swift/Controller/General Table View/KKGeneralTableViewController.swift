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

    var tableViewType: TableViewType!
    var cashFlowArray: [KKUserAccountDetailWalletTrx]! = []
    var bettingRecordArray: [KKUserBettingHistoryDetails]! = []
    var withdrawHistoryArray: [KKHistoryDetails]! = []
    var depositHistoryArray: [KKHistoryDetails]! = []
    var transferHistoryArray: [KKHistoryDetails]! = []
    var promotionHistoryArray: [KKHistoryDetails]! = []
    var affiliateDownlineArray: [KKAffiliateDownlineDownlines]! = []
    var affiliateTurnoverArray: [KKAffiliateTurnoverCommissionTurnover]! = []
    
    var searchDownlineArray: [KKAffiliateDownlineDownlines]! = []
    var searchTurnoverArray: [KKAffiliateTurnoverCommissionTurnover]! = []

    var payoutArray: [KKPayoutGroup]! = []
    var transactionArray: [KKTransactionTransactions]! = []
    var tableArray: [KKTableGroups]! = []

    var tabGroupArray: [KKUserBettingGroupDetails]! = []
    var historyTabArray: [PickerDetails]!
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
             .History,
             .RebatePayout,
             .AffiliatePayout,
             .RebateTable,
             .AffiliateCommTable:
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
        txtSearch.textColor = .spade_white_FFFFFF
        txtSearch.delegate = self
        txtSearch.returnKeyType = .search
        txtSearch.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)
        
        labelContainer.backgroundColor = .clear
        lblTotal.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
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
            
        case .History:
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
        if (buttonType == .NonCommGame) {
            imgButton.image = UIImage(named: "btn_non_comm")
        } else {
            imgButton.image = UIImage(named: "btn_non_rebate")
        }
        btnNonGame.addTarget(self, action: #selector(btnNonCommRebateGameDidPressed), for: .touchUpInside)
    }
    
    func getLeftDropdownOptions() {
        switch tableViewType {
            
            default:
                leftDropdownOptions = pickerTimeArray
        }
    }
    
    func updateButton() {
        var isHide = true
        if tableViewType == .RebateTable || tableViewType == .AffiliateCommTable {
            if tableArray[selectedTabItem].excludedProducts != nil && !tableArray[selectedTabItem].excludedProducts!.isEmpty{
                isHide = false
            }
        }
        
        if (isHide) {
            btnContainer.isHidden = true
            btnContainerHeight.constant = 0
            btnContainerMarginTop.constant = 0
            btnContainerMarginBottom.constant = btnContainerMarginTop.constant
        } else {
            btnContainer.isHidden = false
            btnContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
            btnContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 20)
            btnContainerMarginBottom.constant = btnContainerMarginTop.constant
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
        case .History:
            tabId = historyTabArray[selectedTabItem].id
            
        case .BettingRecord:
            tabId = String(tabGroupArray[selectedTabItem].code ?? "")
        default:
            break;
        }
        
        if tableViewType == .BettingRecord {
            self.getUserBettingRecordAPI(rightPicker: selectedRightItem.id, tabItem: tabId)
        } else if tableViewType == .AccountDetails {
            self.getUserAccountDetailsAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id, tabItem: tabId)
        } else if tableViewType == .WithdrawHistory {
            self.withdrawHistoryAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id)
        } else if tableViewType == .DepositHistory {
            self.depositHistoryAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id)
        } else if tableViewType == .AffiliateDownline {
            self.getAffiliateDownlineAPI()
        } else if tableViewType == .AffiliateTurnover {
            self.getAffiliateTurnoverAPI()
        } else if tableViewType == .RebateTable || tableViewType == .AffiliateCommTable {
            updateButton()
            contentTableView.reloadData()
        } else if tableViewType == .RebatePayout {
            let total = payoutArray[selectedTabItem].totalRebate ?? ""
            let currency = KKUtil.decodeUserCountryFromCache().currency ?? ""
            lblTotal.text = String(format: KKUtil.languageSelectedStringForKey(key: "rebate_total_rebate"), currency, total)
            contentTableView.reloadData()
        } else if tableViewType == .AffiliatePayout {
            let total = payoutArray[selectedTabItem].totalCommission ?? ""
            let currency = KKUtil.decodeUserCountryFromCache().currency ?? ""
            lblTotal.text = String(format: KKUtil.languageSelectedStringForKey(key: "affiliates_total_comm"), currency, total)
            contentTableView.reloadData()
        } else if tableViewType == .History {
            self.getHistoryAPI(leftPicker: selectedLeftItem.id, rightPicker: selectedRightItem.id, tabItem: tabId)
        }
    }
    
    func returnCellDetails(indexPath: IndexPath) -> [String] {
        
        switch tableViewType {
        
        case .BettingRecord:
            if bettingRecordArray.isEmpty {
                return ["", "", "", "", "", "", ""]
            }
            let details = bettingRecordArray[indexPath.row]
            return [details.trxTimestamp ?? "", String(details.betslipId ?? 0), details.gameName ?? "", details.stake ?? "", details.result ?? "", details.amount ?? "", details.validStake ?? ""]
            
        case .AccountDetails:
            if cashFlowArray.isEmpty {
                return ["", "", "", "", ""]
            }
            let details = cashFlowArray[indexPath.row]
            return [details.trxDate ?? "", details.descriptionValue ?? "", details.tIn ?? "", details.tOut ?? "", details.balance ?? ""]
            
        case .DepositHistory:
            if depositHistoryArray.isEmpty {
                return ["", "", "", "", ""]
            }
            let details = depositHistoryArray[indexPath.row]
            return [details.trxTimestamp ?? "", String(details.transactionId ?? 0), details.amount ?? "", details.status ?? "", details.reason ?? ""]

        case .WithdrawHistory:
            if withdrawHistoryArray.isEmpty {
                return ["", "", "", "", ""]
            }
            let details = withdrawHistoryArray[indexPath.row]
            return [details.trxTimestamp ?? "", String(details.transactionId ?? 0) , details.amount ?? "", details.status ?? "", details.reason ?? ""]
            
        case .History:
            if historyTabArray[selectedTabItem].id == HistoryTab.deposit.rawValue {
                if depositHistoryArray.isEmpty {
                    return ["", "", "", "", ""]
                }
                let details = depositHistoryArray[indexPath.row]
                return [details.trxTimestamp ?? "", String(details.transactionId ?? 0), details.amount ?? "", details.status ?? "", details.reason ?? ""]
            } else if historyTabArray[selectedTabItem].id == HistoryTab.withdraw.rawValue {
                if withdrawHistoryArray.isEmpty {
                    return ["", "", "", "", ""]
                }
                let details = withdrawHistoryArray[indexPath.row]
                return [details.trxTimestamp ?? "", String(details.transactionId ?? 0) , details.amount ?? "", details.status ?? "", details.reason ?? ""]
            } else if historyTabArray[selectedTabItem].id == HistoryTab.transfer.rawValue {
                if transferHistoryArray.isEmpty {
                    return ["", "", "", "", ""]
                }
                let details = transferHistoryArray[indexPath.row]
                return [details.trxTimestamp ?? "", String(details.transactionId ?? 0) , details.amount ?? "", details.status ?? "", details.reason ?? ""]
            } else {
                if promotionHistoryArray.isEmpty {
                    return ["", "", "", "", ""]
                }
                let details = promotionHistoryArray[indexPath.row]
                return [details.trxTimestamp ?? "", String(details.transactionId ?? 0) , details.amount ?? "", details.status ?? "", details.reason ?? ""]
            }
            
        case .AffiliateDownline:
            if searchDownlineArray.isEmpty {
                return ["", "", "", ""]
            }
            let details = searchDownlineArray[indexPath.row]
            return [details.code ?? "", details.username ?? "", details.totalValidStake ?? "", details.totalCommission ?? ""]
            
        case .AffiliateTurnover:
            if searchTurnoverArray.isEmpty {
                return ["", "", "", ""]
            }
            let details = searchTurnoverArray[indexPath.row]
            return [details.code ?? "", details.username ?? "", details.validStake ?? "", details.commission ?? ""]
        
        case .RebatePayout,
             .AffiliatePayout:
            if let payouts = payoutArray[selectedTabItem].payouts {
                if payouts.isEmpty {
                    return ["", "", "", ""]
                }
            }
            let details = payoutArray[selectedTabItem].payouts?[indexPath.row]
            return [details?.date ?? "", details?.validStake ?? "", details?.rate ?? "", details?.commissionAmount ?? ""]

        case .RebateTrans,
             .AffiliateCommTrans:
            if transactionArray.isEmpty {
                return ["", "", "", ""]
            }
            let details = transactionArray[indexPath.row]
            return [details.trxDate ?? "", details.code ?? "", details.type ?? "", details.amount ?? ""]

        case .RebateTable,
             .AffiliateCommTable:
            if let rebates = tableArray[selectedTabItem].rebates {
                if rebates.isEmpty {
                    return ["", ""]
                }
            }
            let details = tableArray[selectedTabItem].rebates?[indexPath.row]
            return [details?.validStake ?? "", details?.rate ?? ""]

        default:
            return []
        }
    }
    
    @IBAction func btnSearchDidPressed() {
        
    }
    
    @objc func btnNonCommRebateGameDidPressed() {
        let excludedRebateProducts = tableArray[selectedTabItem].excludedProducts
        if excludedRebateProducts == nil {
            return
        }
        
        let vc = KKGeneralPopUpTableViewController.init()
        vc.popupTableViewType = tableViewType == .AffiliateCommTable ? .NonCommGame : .NonRebateGame
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
    
    func getUserAccountDetailsAPI(leftPicker: String, rightPicker: String, tabItem: String) {
        self.showAnimatedLoader()
        KKApiClient.getUserAccountDetails(filter: leftPicker).execute { cashFlowResponse in
            self.hideAnimatedLoader()
            self.cashFlowArray = cashFlowResponse.results?.walletTrx
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
            self.withdrawHistoryArray = withdrawHistoryResponse.results?.history
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
            self.depositHistoryArray = depositHistoryResponse.results?.history
            self.contentTableView.reloadData()
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func getAffiliateDownlineAPI() {
        self.showAnimatedLoader()
        KKApiClient.getAffiliateDownline().execute { response in
            self.hideAnimatedLoader()
            self.affiliateDownlineArray = response.results?.downlines
            self.filterUsername()
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func getAffiliateTurnoverAPI() {
        self.showAnimatedLoader()
        KKApiClient.getAffiliateTurnover().execute { response in
            self.hideAnimatedLoader()
            self.affiliateTurnoverArray = response.results?.commissionTurnover
            self.filterUsername()
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func getHistoryAPI(leftPicker: String, rightPicker: String, tabItem: String){
        self.showAnimatedLoader()
        KKApiClient.getHistory(filter: leftPicker, status: rightPicker, groupCode: tabItem).execute { response in
            self.hideAnimatedLoader()
            if tabItem == HistoryTab.withdraw.rawValue {
                self.withdrawHistoryArray = response.results?.history
            } else if tabItem == HistoryTab.deposit.rawValue {
                self.depositHistoryArray = response.results?.history
            } else if tabItem == HistoryTab.transfer.rawValue {
                self.transferHistoryArray = response.results?.history
            } else if tabItem == HistoryTab.promotion.rawValue {
                self.promotionHistoryArray = response.results?.history
            }
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
    
    func filterUsername() {
        if let text = txtSearch.text {
            if (text.isEmpty) {
                if (tableViewType == .AffiliateDownline) {
                    searchDownlineArray = affiliateDownlineArray
                } else {
                    searchTurnoverArray = affiliateTurnoverArray
                }
            } else {
                if (tableViewType == .AffiliateDownline) {
                    searchDownlineArray = affiliateDownlineArray.filter { $0.username!.lowercased().contains(txtSearch.text!.lowercased())}

                } else {
                    searchTurnoverArray = affiliateTurnoverArray.filter { $0.username!.lowercased().contains(txtSearch.text!.lowercased())}
                }
            }
        } else {
            if (tableViewType == .AffiliateDownline) {
                searchDownlineArray = affiliateDownlineArray
            } else {
                searchTurnoverArray = affiliateTurnoverArray
            }
        }
        
        contentTableView.reloadData()
    }
}

extension KKGeneralTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == rightPickerTxtValue {
            showPickerView(optionList: rightDropdownOptions)
            pickerTextField = textField
            isRight = true
            isLeft = false
            
            //TODO: KEITH, add the subclass, and add disable copy paste pop up
            textField.tintColor = UIColor.clear
            
        } else if textField == leftPickerTxtValue {
            showPickerView(optionList: leftDropdownOptions)
            pickerTextField = textField
            selectedLeftItem = selectedPickerItem
            isRight = false
            isLeft = true
            
            //TODO: KEITH, add the subclass, and add disable copy paste pop up
            textField.tintColor = UIColor.clear
        }
    }
    
    @objc func textfieldDidChange(_ sender: UITextField) {
        filterUsername()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtSearch {
            filterUsername()
            view.endEditing(true)
        }
        return true
    }
}

extension KKGeneralTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tableViewType {
        case .RebatePayout,
             .AffiliatePayout,
             .RebateTable,
             .AffiliateCommTable:
            return tableArray.count

        case .BettingRecord:
            return tabGroupArray.count
            
        case .History:
            return historyTabArray.count
            
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
        case .RebatePayout,
             .AffiliatePayout,
             .RebateTable,
             .AffiliateCommTable:
            cell.lblTitle.text = tableArray[indexPath.item].name ?? ""
        
        case .History:
            cell.lblTitle.text = historyTabArray[indexPath.item].name

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
            
        case .History:
            if historyTabArray[selectedTabItem].id == HistoryTab.deposit.rawValue {
                return depositHistoryArray.count
            } else if historyTabArray[selectedTabItem].id == HistoryTab.withdraw.rawValue {
                return withdrawHistoryArray.count
            } else if historyTabArray[selectedTabItem].id == HistoryTab.transfer.rawValue {
                return transferHistoryArray.count
            } else {
                return promotionHistoryArray.count
            }
            
        case .DepositHistory:
            return depositHistoryArray.count
            
        case .WithdrawHistory:
            return withdrawHistoryArray.count
            
        case .AffiliateDownline:
            return searchDownlineArray.count
            
        case .AffiliateTurnover:
            return searchTurnoverArray.count
            
        case .RebatePayout,
             .AffiliatePayout:
            return payoutArray.count

        case .RebateTrans,
             .AffiliateCommTrans:
            return transactionArray.count
            
        case .RebateTable,
             .AffiliateCommTable:
            return tableArray[selectedTabItem].rebates?.count ?? 0
            
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
