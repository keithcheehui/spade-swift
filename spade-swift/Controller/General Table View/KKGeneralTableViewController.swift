//
//  KKGeneralTableViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 18/06/2021.
//

import UIKit

class KKGeneralTableViewController: KKTableBaseViewController {

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

    var leftTitle: String!
    var leftValue: String!
    var leftDropdownOptions: [PickerDetails] = []
    
    var rightTitle: String!
    var rightValue: String!
    var rightDropdownOptions: [PickerDetails] = []
    
    var leftItem: String!
    var rightItem: String!
    
    var isLeft = false
    var isRight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
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
            leftValue = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
            leftItem = ""
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_game_platform")
            rightValue = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
            rightItem = ""
            self.showTopContainer(shouldShow: true, withRightPicker: true)
            
        case .AccountDetails:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            leftValue = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
            leftItem = ""
            self.showTopContainer(shouldShow: true, withRightPicker: false)
        
        case .DepositHistory:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            leftValue = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
            leftItem = ""
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_withdraw_status")
            rightValue = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
            rightItem = ""
            self.showTopContainer(shouldShow: true, withRightPicker: true)
        
        case .WithdrawHistory:
            leftTitle = KKUtil.languageSelectedStringForKey(key: "picker_trans_time")
            leftValue = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
            leftItem = ""
            
            rightTitle = KKUtil.languageSelectedStringForKey(key: "picker_withdraw_status")
            rightValue = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
            rightItem = ""
            self.showTopContainer(shouldShow: true, withRightPicker: true)
        
        default:
            self.showTopContainer(shouldShow: false, withRightPicker: false)
        }
    }

    func showTopContainer(shouldShow: Bool, withRightPicker: Bool){
        if (shouldShow){
            topContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 35)
            topContainer.isHidden = false
            getLeftDropdownOptions()
            
            showDropdownOption(showRight: withRightPicker)
        } else {
            topContainerHeight.constant = 0
            topContainer.isHidden = true
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
    
    func getLeftDropdownOptions() {
        switch tableViewType {
            
//            case .WithdrawHistory:
//                leftDropdownOptions = pickerStatusArray
            default:
                leftDropdownOptions = pickerTimeArray
        }
    }
    
    func updateTable() {
        if (isLeft && !isRight) {
            leftItem = ""
            for item in leftDropdownOptions {
                if (item.name == pickerTextField.text!) {
                    leftItem = item.id
                    break;
                }
            }
        } else if (!isLeft && isRight) {
            rightItem = ""
            for item in rightDropdownOptions {
                if (item.name == pickerTextField.text!) {
                    rightItem = item.id
                    break;
                }
            }
        }
        
        if tableViewType == .BettingRecord {
            self.getUserBettingRecordAPI(leftPicker: leftItem, rightPicker: rightItem, tabItem: selectedTabItem)
        } else if tableViewType == .AccountDetails {
            self.getUserAccountDetailsAPI(leftPicker: leftItem, tabItem: selectedTabItem)
        } else if tableViewType == .WithdrawHistory {
            self.withdrawHistoryAPI(leftPicker: leftItem, rightPicker: rightItem)
        } else if tableViewType == .DepositHistory {
            self.depositHistoryAPI(leftPicker: leftItem, rightPicker: rightItem)
        }
    }
    
    @objc
    override func didTapDone() {
        view.endEditing(true)
        pickerView.isHidden = true
        if (isRight && rightItem == nil) {
            return
        }
        
        if (isLeft && leftItem == nil) {
            return
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
            isRight = false
            isLeft = true
        }
        
        //TODO: KEITH, add the subclass, and add disable copy paste pop up
        textField.tintColor = UIColor.clear
    }
}
