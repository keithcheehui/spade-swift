//
//  KKGeneralTableViewCell.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/06/2021.
//

import UIKit

class KKGeneralTableViewCell: UITableViewCell {
    
    struct CellViewConstant {
        
        static let cellViewHeight = CGFloat(30)
    }
    
    var cellView: UIView!
    var labelArray: [UILabel]! = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        cellView = UIView.init()
        cellView.backgroundColor = .clear
        self.contentView.addSubview(cellView)
        
        for index in 1...5 {
            
            let label = UILabel.init()
            label.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
            label.textColor = .spade_white_FFFFFF
            label.textAlignment = .center
            label.numberOfLines = 1
            label.tag = index
            cellView.addSubview(label)
            
            labelArray.append(label)
        }
    }
    
    func setUpCellDetails(width: CGFloat, content: [String], type: TableViewType) {
                
        for (index, titleString) in content.enumerated() {
            
            labelArray[index].text = titleString.capitalized
            labelArray[index].frame = CGRect(x: CGFloat(index) * (width / CGFloat(content.count)), y: 0, width: (width / CGFloat(content.count)), height: CellViewConstant.cellViewHeight)
        }
        
        cellView.frame = CGRect(x: 0, y: 0, width: width, height: CellViewConstant.cellViewHeight)
    }
    
    class func calculateCellDetailsHeight() -> CGFloat {
        
        return CellViewConstant.cellViewHeight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
