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
    @IBOutlet weak var imgGameIcon: UIImageView!
    @IBOutlet weak var lblGameName: UILabel!
    @IBOutlet weak var gameCollectionView: UICollectionView!
        
    @IBOutlet weak var containerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var gameContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var gameContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var gameNameContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var btnBetNowHeight: NSLayoutConstraint!
    @IBOutlet weak var gameCollectionViewWidth: NSLayoutConstraint!
    
    enum itemType: String {
        case product = "Product"
        case gameType = "Game type"
    }
    
    var selectedLiveCasinoIndex = 0
    var liveCasinoArray: [KKGroupPlatformDetails]! = []
    var homeViewController: KKHomeViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: 200), height: KKUtil.ConvertSizeByDensity(size: 75))
        
        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.register(UINib(nibName: "KKLiveCasinoItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.liveCasinoCVCIdentifier)
    }
    
    func initialLayout(){
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 10)
        containerMarginBottom.constant = containerMarginTop.constant
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 50)
        containerMarginRight.constant = containerMarginLeft.constant
        
        gameContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: 200)
        gameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 250)
        gameNameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 35)
        btnBetNowHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        gameCollectionViewWidth.constant = KKUtil.ConvertSizeByDensity(size: 200)

        lblGameName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
        lblGameName.textColor = UIColor.spade_white_FFFFFF
        
        defaultValue()
    }
    
    func defaultValue() {
        imgBG.setUpImage(with: liveCasinoArray[selectedLiveCasinoIndex].img2)
        imgGameIcon.isHidden = true
        lblGameName.isHidden = true
    }
    
    ///Button Actions
    @IBAction func btnBetNowDidPressed(){
        if liveCasinoArray[selectedLiveCasinoIndex].type == itemType.gameType.rawValue {
            let vc = KKPlatformViewController()
            vc.homeViewController = homeViewController
            vc.selectedMenuItem = selectedLiveCasinoIndex
            vc.platformCode = selectedGroupCode
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            //TODO: PUT Web view for game redirect url
            if (KKUtil.isUserLogin()) {
                self.navigationController?.pushViewController(KKWebViewController(), animated: true)
            } else {
                homeViewController.showLoginPopup()
            }
        }
    }
}

extension KKLiveCasinoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //Game List
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveCasinoArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.liveCasinoCVCIdentifier, for: indexPath) as? KKLiveCasinoItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.img4.setUpImage(with: liveCasinoArray[indexPath.item].img)

        if (selectedLiveCasinoIndex == indexPath.row){
            cell.imgHover.isHidden = false
        } else {
            cell.imgHover.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedLiveCasinoIndex = indexPath.row
        gameCollectionView.reloadData()
        
        imgBG.setUpImage(with: liveCasinoArray[indexPath.item].img2)
    }
}
