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
    
    var selectedLiveCasinoIndex = 0
    var liveCasinoArray: [KKGroupPlatformDetails]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: 200), height: KKUtil.ConvertSizeByDensity(size: 70))
        
        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.register(UINib(nibName: "KKLiveCasinoItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.liveCasinoCVCIdentifier)
    }
    
    func initialLayout(){
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 30)
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
        imgBG.image = UIImage(named: "ic_girl_table_ag")
        imgGameIcon.image = UIImage(named: "ic_ag")
        lblGameName.text = liveCasinoArray[selectedLiveCasinoIndex].name!
    }
    
    ///Button Actions
    @IBAction func btnBetNowDidPressed(){
        
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
        
        cell.imgGirlIcon.setUpImage(with: liveCasinoArray[indexPath.item].img)
        cell.lblGameName.text = liveCasinoArray[indexPath.item].name!
        
        switch indexPath.row {
        case 0:
//            cell.imgGirlIcon.image = UIImage(named: "ic_girl_ag")
            cell.imgGameIcon.image = UIImage(named: "ic_ag")
//            cell.lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_ag")
        case 1:
//            cell.imgGirlIcon.image = UIImage(named: "ic_girl_sa")
            cell.imgGameIcon.image = UIImage(named: "ic_sa")
//            cell.lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_sa")
        case 2:
//            cell.imgGirlIcon.image = UIImage(named: "ic_girl_dg")
            cell.imgGameIcon.image = UIImage(named: "ic_dg")
//            cell.lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_dg")
        case 3:
//            cell.imgGirlIcon.image = UIImage(named: "ic_girl_bg")
            cell.imgGameIcon.image = UIImage(named: "ic_bg")
//            cell.lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_bg")
        default:
            break;
        }

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
        
//        imgGameIcon.setUpImage(with: liveCasinoArray[indexPath.item].img)
        lblGameName.text = liveCasinoArray[indexPath.item].name!
        
        switch indexPath.row {
        case 0:
            imgBG.image = UIImage(named: "ic_girl_table_ag")
            imgGameIcon.image = UIImage(named: "ic_ag")
//            lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_ag")
        case 1:
            imgBG.image = UIImage(named: "ic_girl_table_sa")
            imgGameIcon.image = UIImage(named: "ic_sa")
//            lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_sa")
        case 2:
            imgBG.image = UIImage(named: "ic_girl_table_dg")
            imgGameIcon.image = UIImage(named: "ic_dg")
//            lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_dg")
        case 3:
            imgBG.image = UIImage(named: "ic_girl_table_bg")
            imgGameIcon.image = UIImage(named: "ic_bg")
//            lblGameName.text = KKUtil.languageSelectedStringForKey(key: "live_casino_bg")
        default:
            break;
        }
    }
}
