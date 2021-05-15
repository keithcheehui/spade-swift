//
//  KKSelectCountryViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit

class KKSelectCountryViewController: KKBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var countryCollectionView: UICollectionView!

    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var titleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var titleHeight: NSLayoutConstraint!

    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130), height: KKUtil.ConvertSizeByDensity(size: 40))
        
        countryCollectionView.collectionViewLayout = flowLayout
        countryCollectionView.register(UINib(nibName: "KKCountryItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.countryCVCIdentifier)
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 25)
        
        lblTitle.text = KKUtil.languageSelectedStringForKey(key: "country_title")
        lblTitle.textColor = UIColor.spade_white_FFFFFF
        lblTitle.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
    }

    
    ///Button Actions
    @IBAction func btnConfirmDidPressed(){
        KKUtil.redirectToHome()
    }
    
    ///Live Chat
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.countryCVCIdentifier, for: indexPath) as? KKCountryItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (indexPath.row == selectedIndex) {
            cell.imgCountry.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 2)
        } else {
            cell.imgCountry.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 0)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
        return
    }
}

