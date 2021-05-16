//
//  KKGameListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKGameListViewController: KKBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
        
    @IBOutlet weak var containerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerMarginBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
        initFlowLayout()
    }
    
    func initialLayout(){
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 30)
        containerMarginBottom.constant = containerMarginTop.constant
    }
    
    func initFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        var size = CGFloat(0)
        if (KKUtil.isSmallerPhone()){
            size = KKUtil.ConvertSizeByDensity(size: gameCollectionView.frame.size.height / 2 - 65)
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        } else {
            size = KKUtil.ConvertSizeByDensity(size: gameCollectionView.frame.size.height / 2 - 60)
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 20)
        }
        //for double row
//        flowLayout.itemSize = CGSize(width: size, height: size)
        
        //for single row
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: (gameCollectionView.frame.size.height - 60) / 2), height: KKUtil.ConvertSizeByDensity(size: gameCollectionView.frame.size.height - 60))

        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.register(UINib(nibName: "KKSingleRowGameItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.gameItemCVCIdentifier)
    }
    
    //Game List
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.gameItemCVCIdentifier, for: indexPath) as? KKSingleRowGameItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        return cell
    }
}
