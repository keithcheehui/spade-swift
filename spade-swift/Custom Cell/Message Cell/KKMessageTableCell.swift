//
//  KKMessageTableCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 23/05/2021.
//

import Foundation
import UIKit

class KKMessageTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblMsgTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMsgContent: UILabel!
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLabelHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        containerView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        containerView.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        containerView.layer.cornerRadius = 8
        
        topViewHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        bottomLabelHeight.constant = 0
        
        lblMsgTitle.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblDate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblMsgContent.font = lblDate.font

        lblMsgTitle.textColor = UIColor.spade_white_FFFFFF
        lblDate.textColor = lblMsgTitle.textColor
        lblMsgContent.textColor = lblMsgTitle.textColor
    }
    
    func setUpMessageDetails(messageDetails: KKInboxMessageDetails, isHidden: Bool)  -> CGFloat {
        
        let maximumLabelSize = CGSize(width: ScreenSize.width*0.6, height: .greatestFiniteMagnitude)
        
        lblMsgTitle.text = messageDetails.title
        lblDate.text = messageDetails.updatedAt
        lblMsgContent.text = messageDetails.content
        
        let msgContentLabelAttributes: [NSAttributedString.Key: Any] = [
            .font   : UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        ]
        
        let expectedMsgContentLabelSize = KKUtil.getLabelSize(text: messageDetails.content!,
                                                              maximumLabelSize: maximumLabelSize,
                                                              attributes: msgContentLabelAttributes)
        
        if !isHidden {
            
            return expectedMsgContentLabelSize.height
        }
        
        return CGFloat(0)
    }
    
    class func calculateMessageDetailsHeight(messageDetails: KKInboxMessageDetails, isHidden: Bool)  -> CGFloat {
        
        let maximumLabelSize = CGSize(width: ScreenSize.width*0.6, height: .greatestFiniteMagnitude)
        
        let msgContentLabelAttributes: [NSAttributedString.Key: Any] = [
            .font   : UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        ]
        
        let expectedMsgContentLabelSize = KKUtil.getLabelSize(text: messageDetails.content!,
                                                              maximumLabelSize: maximumLabelSize,
                                                              attributes: msgContentLabelAttributes)
        
        if !isHidden {
            
            return expectedMsgContentLabelSize.height + KKUtil.ConvertSizeByDensity(size: 50)
        }
        
        return KKUtil.ConvertSizeByDensity(size: 50)
    }
}

