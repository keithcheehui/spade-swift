//
//  KKSupportViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 26/04/2021.
//

import Foundation
import UIKit

class KKSupportViewController: KKBaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var liveChatCollectionView: UICollectionView!
    @IBOutlet weak var sideMenuTableView: UITableView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    
    var liveChatArray: [KKLiveChatDetails]! = []
    var sideMenuList: [SideMenuDetails] = []
    var selectedViewType = SupportSideMenu.liveChat.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        setupFlowLayout()
        appendSideMenuList()
        
        buttonHover(type: SupportSideMenu.liveChat.rawValue)
        getLiveChatAPI()
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        sideMenuWidth.constant = ConstantSize.sideMenuWidth
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
    }
    
    func setupFlowLayout() {
        let itemSizeWidth = liveChatCollectionView.frame.size.width/4 - ConstantSize.paddingStandard
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemSizeWidth, height: KKUtil.ConvertSizeByDensity(size: 200))
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: ConstantSize.paddingSecondaryHalf, bottom: ConstantSize.paddingSecondaryHalf, right: ConstantSize.paddingSecondaryHalf)
        flowLayout.minimumInteritemSpacing = ConstantSize.paddingSecondaryHalf
        flowLayout.minimumLineSpacing = ConstantSize.paddingSecondaryHalf
        
        liveChatCollectionView.collectionViewLayout = flowLayout
        liveChatCollectionView.register(UINib(nibName: "KKLiveChatCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.liveChatCVCIdentifier)
    }
    
    func appendSideMenuList() {
        sideMenuTableView.register(UINib(nibName: "KKSideMenuTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.sideMenuTVCIdentifier)

        sideMenuList.removeAll()
        
        var details = SideMenuDetails.init()
        for item in SupportSideMenu.allCases {
            switch item {
            case .liveChat:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "support_live_chat")
                details.imgIcon = "ic_livechat"
                
            case .faq:
                details.id = item.rawValue
                details.title = KKUtil.languageSelectedStringForKey(key: "support_faq")
                details.imgIcon = "ic_faq"
            }
            sideMenuList.append(details)
        }
        sideMenuTableView.reloadData()
    }
    
    //MARK:- API Calls
    
    func getLiveChatAPI() {
        
        self.showAnimatedLoader()
        
        KKApiClient.getLiveChat().execute { LiveChatResponse in
            
            self.hideAnimatedLoader()
            self.liveChatArray = LiveChatResponse.results?.liveChats
            self.liveChatCollectionView.reloadData()
            
        } onFailure: { errorMessage in
            
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buttonHover(type: Int){
        mainView.isHidden = true
        liveChatCollectionView.isHidden = true
                
        switch type {
        case SupportSideMenu.faq.rawValue:
            mainView.isHidden = false
            changeView(vc: KKFaqViewController())
            break;
        default:
            liveChatCollectionView.isHidden = false
            break;
        }
    }
    
    func changeView(vc: KKBaseViewController){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        vc.tableContentView = contentView
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
}

extension KKSupportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveChatArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.liveChatCVCIdentifier, for: indexPath) as? KKLiveChatCollectionViewCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.lblHotline.text = liveChatArray[indexPath.item].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let link = liveChatArray[indexPath.row].redirect_link
        
        if let url = URL(string: link!) {
            UIApplication.shared.open(url)
        }
    }
}

extension KKSupportViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.sideMenuTVCIdentifier, for: indexPath) as? KKSideMenuTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        if (selectedViewType == indexPath.row){
            cell.imgHover.isHidden = false
            cell.lblName.font = ConstantSize.sideMenuSelectedFont
        } else {
            cell.imgHover.isHidden = true
            cell.lblName.font = ConstantSize.sideMenuFont
        }
        
        cell.imgIcon.image = UIImage(named: sideMenuList[indexPath.row].imgIcon)
        cell.lblName.text = sideMenuList[indexPath.row].title
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedViewType = indexPath.row
        buttonHover(type: selectedViewType)
        sideMenuTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConstantSize.menuItemHeight
    }
}
