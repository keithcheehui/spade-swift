//
//  KKSelectCountryViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 16/05/2021.
//

import Foundation
import UIKit
import KeychainSwift

class KKSelectCountryViewController: KKBaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var countryCollectionView: UICollectionView!

    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var lblTitleMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var lblTitleMarginRight: NSLayoutConstraint!
    @IBOutlet weak var titleMarginTop: NSLayoutConstraint!
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var btnConfirmHeight: NSLayoutConstraint!

    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: 10)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: 130), height: KKUtil.ConvertSizeByDensity(size: 40))
        
        countryCollectionView.collectionViewLayout = flowLayout
        countryCollectionView.register(UINib(nibName: "KKCountryItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.countryCVCIdentifier)
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 90 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        lblTitleMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 60)
        lblTitleMarginRight.constant = lblTitleMarginLeft.constant
        btnConfirmMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 50)
        btnConfirmHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        
        lblTitle.text = KKUtil.languageSelectedStringForKey(key: "country_title")
        lblTitle.textColor = UIColor.spade_white_FFFFFF
        lblTitle.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 14))
    }

    
    ///Button Actions
    @IBAction func btnConfirmDidPressed(){
        
        do {
            KeychainSwift().set(try JSONEncoder().encode(KKSingleton.sharedInstance.countryArray[selectedIndex]), forKey: CacheKey.selectedCountry)
            KKUtil.redirectToHome()
        }
        catch {
            self.showAlertView(type: .Error, alertMessage: error.localizedDescription)
        }
    }
}

extension KKSelectCountryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KKSingleton.sharedInstance.countryArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.countryCVCIdentifier, for: indexPath) as? KKCountryItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.lblCountryName.text = KKSingleton.sharedInstance.countryArray[indexPath.item].name
        cell.imgCountry.setUpImage(with: KKSingleton.sharedInstance.countryArray[indexPath.item].img)
        
        if (indexPath.row == selectedIndex) {
            cell.imgCountry.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 2)
        } else {
            cell.imgCountry.layer.borderWidth = KKUtil.ConvertSizeByDensity(size: 0)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.item
        collectionView.reloadData()
    }
}

