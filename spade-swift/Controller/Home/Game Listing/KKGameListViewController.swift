//
//  KKGameListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKGameListViewController: KKBaseViewController {
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
        
    @IBOutlet weak var containerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerMarginBottom: NSLayoutConstraint!
    
    enum itemType: String {
        case product = "Product"
        case gameType = "Game type"
    }
    
    var gameListArray: [KKGroupPlatformDetails]! = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
        updateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gameCollectionView.reloadData()
    }
    
    public func updateLayout(){
        initFlowLayout()
        gameCollectionView.reloadData()
    }
    
    func initialLayout(){
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 10)
        containerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 10)
    }
    
    func initFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0

        var size = CGFloat(0)
//        size = KKUtil.ConvertSizeByDensity(size: gameCollectionView.frame.size.height / 2 - 75)

        if (isSingleRow()){
//            size = KKUtil.ConvertSizeByDensity(size: 170)
//            flowLayout.itemSize = CGSize(width: size, height: size * 1.56)
            size = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 220 : 250)
            flowLayout.itemSize = CGSize(width: size / 1.3, height: size)
            flowLayout.minimumLineSpacing = 5
            
            if (KKUtil.isSmallerPhone()){
                flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            } else {
                flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 20)
            }
        } else {
            if (selectedGameType == GameType.fishing) {
                size = KKUtil.ConvertSizeByDensity(size: 120)

                if (KKUtil.isSmallerPhone()){
                    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                } else {
                    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 20)
                }
            } else {
                size = KKUtil.ConvertSizeByDensity(size: 115)

                if (KKUtil.isSmallerPhone()){
                    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                } else {
                    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 20)
                }
            }
            
            flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 60 : 60)
            flowLayout.itemSize = CGSize(width: size, height: size)
        }

        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.register(UINib(nibName: "KKSingleRowGameItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.gameItemCVCIdentifier)
    }
    
    func isSingleRow() -> Bool{
        switch selectedGameType {
        case GameType.hotGame, GameType.fishing:
            return false
        default:
            return true
        }
    }
}

extension KKGameListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameListArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.gameItemCVCIdentifier, for: indexPath) as? KKSingleRowGameItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
                        
//        var imageName = ""
//        var showBetButton = true
//
//        switch selectedGameType {
//        case GameType.hotGame:
//            imageName = getHotGameImage(index: indexPath.row)
//        case GameType.slots:
//            imageName = getSlotGameImage(index: indexPath.row)
//        case GameType.fishing:
//            imageName = getFishingGameImage(index: indexPath.row)
//        case GameType.p2pGame:
//            imageName = getP2PGameImage(index: indexPath.row)
//        case GameType.sports:
//            imageName = getSportGameImage(index: indexPath.row)
//            showBetButton = false
//        case GameType.lottery:
//            imageName = getLotteryGameImage(index: indexPath.row)
//        case GameType.esports:
//            imageName = getEsportGameImage(index: indexPath.row)
//        default:
//            break
//        }
//
//        cell.imgGameImage.image = UIImage(named: imageName)
        
        cell.imgGameImage.setUpImage(with: gameListArray[indexPath.item].img)
        cell.btnBetNow.isHidden = selectedGameType != GameType.sports
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if gameListArray[indexPath.item].type == itemType.gameType.rawValue {
            let vc = KKPlatformViewController()
            vc.platformCode = gameListArray[indexPath.item].code
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            //TODO: PUT Web view for game redirect url
        }
    }
    
//    func getHotGameImage(index: Int) -> String {
//        let imageName = "ic_game_example"
//        return imageName
//    }
//
//    func getSlotGameImage(index: Int) -> String {
//        var imageName = ""
//
//        switch index {
//        case 0:
//            imageName = "bg_mega888"
//        case 1:
//            imageName = "bg_918"
//        case 2:
//            imageName = "bg_pussy888"
//        default:
//            imageName = "bg_sky1388"
//        }
//
//        return imageName
//    }
//
//    func getFishingGameImage(index: Int) -> String {
//        let imageName = "bg_fish_" + String(index + 1)
//        return imageName
//    }
//
//    func getP2PGameImage(index: Int) -> String {
//        let imageName = "bg_default"
//        return imageName
//    }
//
//    func getSportGameImage(index: Int) -> String {
//        var imageName = "bg_sport_" + String(index + 1)
//
//        if (index > 2) {
//            imageName = "bg_sport_3"
//        }
//
//        return imageName
//    }
//
//    func getLotteryGameImage(index: Int) -> String {
//        var imageName = "bg_lottery_" + String(index + 1)
//
//        if (index > 2) {
//            imageName = "bg_lottery_2"
//        }
//
//        return imageName
//    }
//
//    func getEsportGameImage(index: Int) -> String {
//        var imageName = "bg_esports_" + String(index + 1)
//
//        if (index > 2) {
//            imageName = "bg_esports_2"
//        }
//
//        return imageName
//    }
}
