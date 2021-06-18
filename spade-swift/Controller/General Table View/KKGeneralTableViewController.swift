//
//  KKGeneralTableViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 18/06/2021.
//

import UIKit

class KKGeneralTableViewController: KKBaseViewController {

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var leftContainer: UIView!
    @IBOutlet weak var leftPickerTitle: UILabel!
    @IBOutlet weak var leftPickerValueView: UIView!
    @IBOutlet weak var leftPickerValue: UILabel!
    
    @IBOutlet weak var rightContainer: UIView!
    @IBOutlet weak var rightPickerTitle: UILabel!
    @IBOutlet weak var rightPickerValueView: UIView!
    @IBOutlet weak var rightPickerValue: UILabel!
    
    @IBOutlet weak var topContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerWidth: NSLayoutConstraint!
    
    @IBOutlet weak var contentTableView: UITableView!

    public var leftTitle: String = ""
    public var leftValue: String = ""
    public var leftDropdownOptions: [String] = []
    
    public var rightTitle: String = ""
    public var rightValue: String = ""
    public var rightDropdownOptions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
    }

    func initialLayout() {
        pickerWidth.constant = KKUtil.ConvertSizeByDensity(size: 120)
        
        leftPickerValueView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        rightPickerValueView.backgroundColor = leftPickerValueView.backgroundColor
        
        leftPickerTitle.textColor = .spade_white_FFFFFF
        leftPickerValue.textColor = leftPickerTitle.textColor
        rightPickerTitle.textColor = leftPickerTitle.textColor
        rightPickerValue.textColor = leftPickerTitle.textColor
        
        leftPickerTitle.font = UIFont.systemFont(ofSize: 10)
        leftPickerValue.font = leftPickerTitle.font
        rightPickerTitle.font = leftPickerTitle.font
        rightPickerValue.font = leftPickerTitle.font
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

    func showDropdownOption(showRight: Bool){
        rightContainer.isHidden = true
        
        leftPickerTitle.text = leftTitle
        leftPickerValue.text = leftValue

        if (showRight){
            rightContainer.isHidden = false
            
            rightPickerTitle.text = rightTitle
            rightPickerValue.text = rightValue
        }
    }
    
    @IBAction func leftPickerDidPressed() {
        
    }
    
    @IBAction func rightPickerDidPressed() {
        
    }
}
