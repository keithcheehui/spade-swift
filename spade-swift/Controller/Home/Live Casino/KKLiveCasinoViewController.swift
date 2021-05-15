//
//  KKLiveCasinoViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 15/05/2021.
//

import Foundation
import UIKit

class KKLiveCasinoViewController: KKBaseViewController {
    
    @IBOutlet weak var imgBG: UIImageView!
    
    @IBOutlet weak var imgProfileWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
    }
    
    func initialLayout(){
//        topContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 70)
//        
//        
//        imgBG.image = UIImage(named: "bg_p2p")
//
//        lblCopy.text = KKUtil.languageSelectedStringForKey(key: "home_copy_id")
//        
//        lblProfileName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
//        lblMore.font = lblAffiliate.font
    }
    
    ///Button Actions
    @IBAction func btnProfileDidPressed(){
        self.navigationController?.pushViewController(KKPersonalViewController(), animated: true)
    }
}
