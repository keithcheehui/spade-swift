//
//  KKLiveChatCollectionViewCell.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 09/05/2021.
//

import Foundation
import UIKit

class KKLiveChatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblHotline: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //TODO: KEITH, not sure still got any missing
        //The containerview and lblhotline leave it first, I will link the layout
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
