//
//  KKMessageDetailsTableViewCell.swift
//  spade-swift
//
//  Created by Keith CheeHui on 13/06/2021.
//

import UIKit

class KKMessageDetailsTableViewCell: UITableViewCell {
    
    struct CellViewConstant {
        
        static let iconSize = KKUtil.ConvertSizeByDensity(size: 18)
        static let dateLabelWidth = KKUtil.ConvertSizeByDensity(size: 120)
    }
    
    var messageDetailsView:     UIView!
    var messageIcon:            UIImageView!
    var messageExpandIcon:      UIImageView!
    var messageTitleLabel:      UILabel!
    var messageDateLabel:      UILabel!
    var messageDescLabel:       UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        messageDetailsView = UIView.init()
        messageDetailsView.backgroundColor = .spade_white_FFFFFF
        messageDetailsView.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 1)
        messageDetailsView.layer.borderColor = UIColor(white: 1, alpha: 0.3).cgColor
        messageDetailsView.layer.cornerRadius = 8
        self.contentView.addSubview(messageDetailsView)
        
        messageIcon = UIImageView.init()
        messageIcon.image = UIImage(named: "ic_mail_read")
        messageIcon.contentMode = .scaleAspectFit
        messageDetailsView.addSubview(messageIcon)
        
        messageExpandIcon = UIImageView.init()
        messageExpandIcon.image = UIImage(named: "ic_arrow_down")
        messageExpandIcon.contentMode = .scaleAspectFit
        messageDetailsView.addSubview(messageExpandIcon)
        
        messageTitleLabel = UILabel.init()
        messageTitleLabel.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        messageTitleLabel.textColor = .spade_white_FFFFFF
        messageTitleLabel.textAlignment = .left
        messageTitleLabel.numberOfLines = 1
        messageDetailsView.addSubview(messageTitleLabel)
        
        messageDateLabel = UILabel.init()
        messageDateLabel.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        messageDateLabel.textColor = .spade_white_FFFFFF
        messageDateLabel.textAlignment = .right
        messageDateLabel.numberOfLines = 1
        messageDetailsView.addSubview(messageDateLabel)
        
        messageDescLabel = UILabel.init()
        messageDescLabel.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        messageDescLabel.textColor = .spade_white_FFFFFF
        messageDescLabel.textAlignment = .left
        messageDescLabel.numberOfLines = 0
        messageDetailsView.addSubview(messageDescLabel)
    }
    
    func setUpMessageDetails(messageDetails: KKSystemMessageDetails, isHidden: Bool, tableViewWidth: CGFloat) {
        
        let maximumLabelSize = CGSize(width: tableViewWidth - ConstantSize.paddingSecondaryDouble, height: .greatestFiniteMagnitude)
        
        messageIcon.frame = CGRect(x: ConstantSize.paddingSecondaryHalf, y: ConstantSize.paddingSecondaryHalf, width: CellViewConstant.iconSize, height: CellViewConstant.iconSize)
        
        messageExpandIcon.frame = CGRect(x: tableViewWidth - ConstantSize.paddingSecondaryHalf - CellViewConstant.iconSize, y: ConstantSize.paddingSecondaryHalf, width: CellViewConstant.iconSize, height: CellViewConstant.iconSize)
        
        messageDateLabel.text = messageDetails.updated_at
        messageDateLabel.frame = CGRect(x: messageExpandIcon.frame.origin.x - ConstantSize.paddingSecondaryHalf - CellViewConstant.dateLabelWidth, y: ConstantSize.paddingSecondaryHalf, width: CellViewConstant.dateLabelWidth, height: CellViewConstant.iconSize)
        
        messageTitleLabel.text = messageDetails.title
        messageTitleLabel.frame = CGRect(x: ConstantSize.paddingSecondary + CellViewConstant.iconSize, y: ConstantSize.paddingSecondaryHalf, width: tableViewWidth - ConstantSize.paddingSecondaryDouble + CellViewConstant.iconSize*2 - CellViewConstant.dateLabelWidth, height: CellViewConstant.iconSize)
        
        var height = ConstantSize.paddingSecondary + CellViewConstant.iconSize
        
        messageDescLabel.text = messageDetails.content
        
        let msgContentLabelAttributes: [NSAttributedString.Key: Any] = [
            .font   : UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        ]
        
        let expectedMsgContentLabelSize = KKUtil.getLabelSize(text: messageDetails.content!,
                                                              maximumLabelSize: maximumLabelSize,
                                                              attributes: msgContentLabelAttributes)
        
        messageDescLabel.frame = CGRect(x: ConstantSize.paddingSecondary, y: height + ConstantSize.paddingSecondaryHalf, width: maximumLabelSize.width, height: expectedMsgContentLabelSize.height)
                
        if isHidden {
            
            messageDescLabel.isHidden = true
            messageExpandIcon.transform = CGAffineTransform(rotationAngle: CGFloat(0 * Double.pi / 180.0))
            messageDetailsView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: height)
        }
        else
        {
            height = height + ConstantSize.paddingStandard + expectedMsgContentLabelSize.height
            
            messageDescLabel.isHidden = false
            messageExpandIcon.transform = CGAffineTransform(rotationAngle: CGFloat(180 * Double.pi / 180.0))
            messageDetailsView.frame = CGRect(x: 0, y: 0, width: tableViewWidth, height: height)
        }
    }
    
    class func calculateMessageDetailsHeight(messageDetails: KKSystemMessageDetails, isHidden: Bool, tableViewWidth: CGFloat)  -> CGFloat {
        
        let maximumLabelSize = CGSize(width: tableViewWidth - ConstantSize.paddingSecondaryDouble, height: .greatestFiniteMagnitude)

        let msgContentLabelAttributes: [NSAttributedString.Key: Any] = [
            .font   : UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        ]
        
        let expectedMsgContentLabelSize = KKUtil.getLabelSize(text: messageDetails.content!,
                                                              maximumLabelSize: maximumLabelSize,
                                                              attributes: msgContentLabelAttributes)
        
        var height = ConstantSize.paddingSecondary + CellViewConstant.iconSize
        
        if !isHidden {
            
            height = height + ConstantSize.paddingStandard + expectedMsgContentLabelSize.height
        }
        
        height = height + ConstantSize.paddingSecondaryHalf
        
        return height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
