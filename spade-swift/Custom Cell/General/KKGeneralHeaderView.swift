//
//  KKGeneralHeaderView.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/06/2021.
//

import UIKit

class KKGeneralHeaderView: UITableViewHeaderFooterView {
    
    struct HeaderViewConstant {
        
        static let headerViewHeight = CGFloat(35)
    }
    
    var headerView: UIView!
    var labelArray: [UILabel]! = []

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        headerView = UIView.init()
        headerView.backgroundColor = .spade_blue_292969
        self.contentView.addSubview(headerView)
    }
    
    func setUpHeaderView(width: CGFloat, type: TableViewType) {
        
        let headerTitleArray = KKUtil.getHeaderTitleViaTableViewType(tableViewType: type)
        for index in 1...headerTitleArray.count {
            
            let label = UILabel.init()
            label.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
            label.textColor = .spade_orange_FFBA00
            label.textAlignment = .center
            label.numberOfLines = 1
            label.tag = index
            headerView.addSubview(label)
            
            labelArray.append(label)
        }
        
        for (index, titleString) in headerTitleArray.enumerated() {
            
            let label = labelArray[index]
            label.text = titleString
            label.frame = CGRect(x: CGFloat(index) * (width / CGFloat(headerTitleArray.count)), y: 0, width: (width / CGFloat(headerTitleArray.count)), height: HeaderViewConstant.headerViewHeight)
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: HeaderViewConstant.headerViewHeight)
    }
    
    func setUpHeaderView(width: CGFloat, type: PopupTableViewType) {
        
        let headerTitleArray = KKUtil.getHeaderTitleViaTableViewType(popupTableViewType: type)
        for index in 1...headerTitleArray.count {
            
            let label = UILabel.init()
            label.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
            label.textColor = .spade_orange_FFBA00
            label.textAlignment = .center
            label.numberOfLines = 1
            label.tag = index
            headerView.addSubview(label)
            
            labelArray.append(label)
        }
        
        for (index, titleString) in headerTitleArray.enumerated() {
            
            let label = labelArray[index]
            label.text = titleString
            label.frame = CGRect(x: CGFloat(index) * (width / CGFloat(headerTitleArray.count)), y: 0, width: (width / CGFloat(headerTitleArray.count)), height: HeaderViewConstant.headerViewHeight)
        }
        
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: HeaderViewConstant.headerViewHeight)
    }
    
    class func calculateHeaderViewHeight() -> CGFloat {
        
        return HeaderViewConstant.headerViewHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
