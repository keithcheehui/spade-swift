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
    var leftDropdownOptions: [String] = []
    
    var rightTitle: String!
    var rightValue: String!
    var rightDropdownOptions: [String] = []
    
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
            leftTitle = "Bet Time"
            leftValue = "All Time"
            
            rightTitle = "Gaming Platform"
            rightValue = "All Provider"
            self.showTopContainer(shouldShow: true, withRightPicker: true)
            
        case .AccountDetails:
            leftTitle = "Transaction Time"
            leftValue = "All Time"
            self.showTopContainer(shouldShow: true, withRightPicker: false)
        
        case .DepositHistory:
            leftTitle = "Deposit Status"
            leftValue = "All Status"
            self.showTopContainer(shouldShow: true, withRightPicker: false)
        
        case .WithdrawHistory:
            leftTitle = "Deposit Status"
            leftValue = "All Status"
            self.showTopContainer(shouldShow: true, withRightPicker: false)
        
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
            
            case .WithdrawHistory:
                leftDropdownOptions = KKBaseViewController().pickerStatusArray
            default:
                leftDropdownOptions = KKBaseViewController().pickerTimeArray
        }
    }
}

extension KKGeneralTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == rightPickerTxtValue {
            showPickerView(optionList: rightDropdownOptions)
            pickerTextField = textField
        } else {
            showPickerView(optionList: leftDropdownOptions)
            pickerTextField = textField
        }
        
        //TODO: KEITH, add the subclass, and add disable copy paste pop up
        textField.tintColor = UIColor.clear
    }
}
