//
//  KKAnnouncementTableCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 10/05/2021.
//

import Foundation
import UIKit

class KKAnnouncementTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.spade_white_FFFFFF.cgColor
        containerView.layer.cornerRadius = 8
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
