//
//  KKSupportViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKSupportViewController: KKBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var lblLiveChat: UILabel!
    @IBOutlet weak var lblFaq: UILabel!
    @IBOutlet weak var imgHoverLiveChat: UIImageView!
    @IBOutlet weak var imgHoverFaq: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var liveChatCollectionView: UICollectionView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var imgMenuIconWidth: NSLayoutConstraint!
    @IBOutlet weak var menuItemHeight: NSLayoutConstraint!
    
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var menuItemMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var separatorHeight: NSLayoutConstraint!
    
    
    enum viewType: Int {
        case liveChat = 0
        case faq = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        buttonHover(type: viewType.liveChat.rawValue)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: 130), height: KKUtil.ConvertSizeByDensity(size: 180))
        
        liveChatCollectionView.collectionViewLayout = flowLayout
        liveChatCollectionView.register(UINib(nibName: "KKLiveChatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.liveChatCVCIdentifier)
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        imgMenuIconWidth.constant = ConstantSize.imgMenuIconWidth
        menuItemHeight.constant = ConstantSize.menuItemHeight
        separatorHeight.constant = ConstantSize.separatorHeight
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        menuItemMarginLeft.constant = ConstantSize.menuItemMarginLeft
        
        lblLiveChat.text = KKUtil.languageSelectedStringForKey(key: "support_live_chat")
        lblFaq.text = KKUtil.languageSelectedStringForKey(key: "support_faq")
        
        lblLiveChat.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 10))
        lblFaq.font = lblLiveChat.font
    }
    
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnLiveChatDidPressed(){
        buttonHover(type: viewType.liveChat.rawValue)
    }
    
    @IBAction func btnFaqDidPressed(){
        buttonHover(type: viewType.faq.rawValue)
    }

    func buttonHover(type: Int){
        imgHoverLiveChat.isHidden = true
        imgHoverFaq.isHidden = true
        
        mainView.isHidden = true
        liveChatCollectionView.isHidden = true
                
        switch type {
        case viewType.faq.rawValue:
            imgHoverFaq.isHidden = false
            mainView.isHidden = false
            changeView(vc: KKFaqViewController())
            break;
        default:
            imgHoverLiveChat.isHidden = false
            liveChatCollectionView.isHidden = false
            break;
        }
    }
    
    func changeView(vc: KKBaseViewController){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
    
    ///Live Chat
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.liveChatCVCIdentifier, for: indexPath) as? KKLiveChatCollectionViewCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        return cell
    }
}
