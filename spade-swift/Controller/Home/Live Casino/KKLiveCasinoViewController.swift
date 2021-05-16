//
//  KKLiveCasinoViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 15/05/2021.
//

import Foundation
import UIKit

class KKLiveCasinoViewController: KKBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialLayout()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: 150), height: KKUtil.ConvertSizeByDensity(size: 50))
        
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
        gameNameContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 50)
        btnBetNowHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        gameCollectionViewWidth.constant = KKUtil.ConvertSizeByDensity(size: 200)

        lblGameName.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
        lblGameName.textColor = UIColor.spade_white_FFFFFF
    }
    
    func updateValue() {
        imgGameIcon.image = UIImage(named: "ic_ky")
        lblGameName.text = "AG Gaming"
    }
    
    ///Button Actions
    @IBAction func btnBetNowDidPressed(){
        
    }
    
    //Game List
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.liveCasinoCVCIdentifier, for: indexPath) as? KKLiveCasinoItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.lblGameName.text = lblGameName.text
        return cell
    }
}
