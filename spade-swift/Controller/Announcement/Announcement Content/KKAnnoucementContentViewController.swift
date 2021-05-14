//
//  KKAnnoucementContentViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 14/05/2021.
//

import Foundation
import UIKit

class KKAnnoucementContentViewController: KKBaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        lblTitle.text = "Bank Changing"
        lblDate.text = "2021-01-23 19:00:00"
        lblContent.text = "Please be informed that from 08 April, we will stop using Pattarakorn - Kbank - 5490. Please check our bank account at the deposit form. Sorry for the incovenience.\n\n\nLegend Gaming Management."
        
        lblTitle.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblDate.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblContent.font = lblDate.font
        
        lblTitle.textColor = UIColor.spade_white_FFFFFF
        lblDate.textColor = lblTitle.textColor
        lblContent.textColor = lblTitle.textColor
    }
}

