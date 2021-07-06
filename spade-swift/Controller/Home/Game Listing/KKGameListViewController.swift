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
        if (isSingleRow()){
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
            
            flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: 30)
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
                    
        cell.imgGameImage.setUpImage(with: gameListArray[indexPath.item].img)
        cell.btnBetNow.isHidden = selectedGameType != GameType.sports
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if gameListArray[indexPath.item].type == itemType.gameType.rawValue {
            let vc = KKPlatformViewController()
            vc.selectedMenuItem = indexPath.item
            vc.platformCode = selectedGroupCode
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            //TODO: PUT Web view for game redirect url
            self.navigationController?.pushViewController(KKWebViewController(), animated: true)
        }
    }
}
