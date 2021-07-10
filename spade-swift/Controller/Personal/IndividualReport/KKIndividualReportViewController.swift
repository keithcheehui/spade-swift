//
//  KKIndividualReportViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/06/2021.
//

import UIKit

class KKIndividualReportViewController: KKBaseViewController {
    
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var groupsCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var leftPickerTitle: UILabel!
    @IBOutlet weak var leftPickerValueView: UIView!
    @IBOutlet weak var leftPickerTxtValue: UITextField!
    
    @IBOutlet weak var topContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerWidth: NSLayoutConstraint!
    
    @IBOutlet weak var totalWinContainer: UIView!
    @IBOutlet weak var lblTotalWin: UILabel!
    @IBOutlet weak var lblTotalWinAmount: UILabel!

    @IBOutlet weak var totalValidBettingContainer: UIView!
    @IBOutlet weak var lblTotalBetting: UILabel!
    @IBOutlet weak var lblTotalBettingAmount: UILabel!
    
    @IBOutlet weak var totalAmountContainer: UIView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var totalRebateContainer: UIView!
    @IBOutlet weak var lblTotalRebate: UILabel!
    @IBOutlet weak var lblTotalRebateAmount: UILabel!
    
    @IBOutlet weak var totalWinContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var totalWinContainerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var totalWinContainerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var totalWinContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var totalWinContainerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var bottomContainerMarginBottom: NSLayoutConstraint!
    
    var leftTitle: String!
    var selectedLeftItem: PickerDetails!
    
    var tabGroupArray: [KKUserBettingGroupDetails]! = []
    var selectedTabItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        selectedLeftItem = pickerTimeArray[selectedTabItem]

        
        setupTopContainer()
        contentLayout()
        setLabelValue()
        initFlowLayout()
    }
    
    func initFlowLayout(){
        groupsCollectionViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        let size = KKUtil.ConvertSizeByDensity(size: 40)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: 5)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: size * 3, height: size)
        
        groupsCollectionView.register(UINib(nibName: "KKTabListItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.tabListItemCVCIdentifier)
        groupsCollectionView.collectionViewLayout = flowLayout
    }
    
    func setupTopContainer() {
        topContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 35)
        pickerWidth.constant = KKUtil.ConvertSizeByDensity(size: 120)
        
        leftPickerValueView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        leftPickerTitle.textColor = .spade_white_FFFFFF
        leftPickerTxtValue.textColor = leftPickerTitle.textColor
        
        leftPickerTitle.font = UIFont.systemFont(ofSize: 10)
        leftPickerTxtValue.font = leftPickerTitle.font
        
        leftPickerTxtValue.inputView = pickerView
        leftPickerTxtValue.inputAccessoryView = pickerToolBarView
        
        leftPickerTitle.text = "Transaction Time"
//        leftPickerTxtValue.text = selectedLeftItem.name
        leftPickerTxtValue.delegate = self
    }
    
    func contentLayout() {
        totalWinContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 60)
        totalWinContainerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 20)
        totalWinContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 10)
        totalWinContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 40)
        totalWinContainerMarginRight.constant = totalWinContainerMarginLeft.constant
        bottomContainerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 30)
        
        totalWinContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        totalWinContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        totalWinContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        totalWinContainer.layer.cornerRadius = 8
        
        totalValidBettingContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        totalValidBettingContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        totalValidBettingContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        totalValidBettingContainer.layer.cornerRadius = 8
        
        totalAmountContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        totalAmountContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        totalAmountContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        totalAmountContainer.layer.cornerRadius = 8
        
        totalRebateContainer.backgroundColor = UIColor(white: 0, alpha: 0.3)
        totalRebateContainer.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        totalRebateContainer.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        totalRebateContainer.layer.cornerRadius = 8
        
        lblTotalWin.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 18))
        lblTotalWinAmount.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 22))
        
        lblTotalBetting.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblTotal.font = lblTotalBetting.font
        lblTotalRebate.font = lblTotalBetting.font
        
        lblTotalBettingAmount.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 18))
        lblTotalAmount.font = lblTotalBettingAmount.font
        lblTotalRebateAmount.font = lblTotalBettingAmount.font
        
        lblTotalWin.textColor = .spade_white_FFFFFF
        lblTotalBetting.textColor = lblTotalWin.textColor
        lblTotal.textColor = lblTotalWin.textColor
        lblTotalRebate.textColor = lblTotalWin.textColor

        lblTotalWinAmount.textColor = .spade_blue_5CB5DE
        
        lblTotalBettingAmount.textColor = .spade_yellow_FFFF00
        lblTotalAmount.textColor = lblTotalBettingAmount.textColor
        lblTotalRebateAmount.textColor = lblTotalBettingAmount.textColor

        lblTotalWin.text = KKUtil.languageSelectedStringForKey(key: "ir_total_win")
        lblTotalBetting.text = KKUtil.languageSelectedStringForKey(key: "ir_total_bet")
        lblTotal.text = KKUtil.languageSelectedStringForKey(key: "ir_total_amount")
        lblTotalRebate.text = KKUtil.languageSelectedStringForKey(key: "ir_total_rebate")
    }
    
    func setLabelValue() {
        lblTotalWinAmount.text = String(format: KKUtil.languageSelectedStringForKey(key: "ir_total_value"), "0")
        lblTotalBettingAmount.text = String(format: KKUtil.languageSelectedStringForKey(key: "ir_total_value"), "0")
        lblTotalAmount.text = String(format: KKUtil.languageSelectedStringForKey(key: "ir_total_value"), "0")
        lblTotalRebateAmount.text = String(format: KKUtil.languageSelectedStringForKey(key: "ir_total_value"), "0")
    }
    
    func getIndividualReportAPI() {
        //TODO: Pending API
    }
    
    @objc
    override func didTapDone() {
        view.endEditing(true)
        pickerView.isHidden = true
        if selectedLeftItem == nil {
            return
        }
        
        leftPickerTxtValue.text = selectedLeftItem.name
    }
}

extension KKIndividualReportViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        showPickerView(optionList: pickerTimeArray)
        pickerTextField = textField
        selectedLeftItem = selectedPickerItem

        //TODO: KEITH, add the subclass, and add disable copy paste pop up
        textField.tintColor = UIColor.clear
    }
}

extension KKIndividualReportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabGroupArray.count
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
        
        cell.lblTitle.text = tabGroupArray[indexPath.item].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTabItem = indexPath.item
        collectionView.reloadData()
        
        return
    }
}
