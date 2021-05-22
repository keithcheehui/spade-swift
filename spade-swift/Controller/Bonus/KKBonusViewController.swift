//
//  KKBonusViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 22/05/2021.
//

import Foundation
import UIKit

class KKBonusViewController: KKBaseViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var bonusCollectionView: UICollectionView!

    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var containerMarginTop: NSLayoutConstraint!
    @IBOutlet weak var containerMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var containerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var containerMarginRight: NSLayoutConstraint!
    @IBOutlet weak var imgTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    
    @IBOutlet weak var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet weak var sideMenuMarginTop: NSLayoutConstraint!
    @IBOutlet weak var sideMenuMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var sideMenuMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var contentViewMarginRight: NSLayoutConstraint!

    @IBOutlet weak var backContainerHeight: NSLayoutConstraint!
    
    let sideMenuItem = ["Slots", "Live Casino", "Fishing"]
    var selectedMenuItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        
        let size = KKUtil.ConvertSizeByDensity(size: 400)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: size, height: size / 2.5)
        
        bonusCollectionView.collectionViewLayout = flowLayout
        bonusCollectionView.register(UINib(nibName: "KKBonusItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.bonusItemCVCIdentifier)
        sideMenuTableView.register(UINib(nibName: "KKBonusMenuTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.bonusTVCIdentifier)
    }
    
    func initialLayout(){
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 30)
        containerMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 20)
        containerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 130)
        containerMarginRight.constant = containerMarginLeft.constant
        imgTitleHeight.constant = KKUtil.ConvertSizeByDensity(size: 45)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        
        sideMenuWidth.constant = KKUtil.ConvertSizeByDensity(size: 120)
        sideMenuMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 10)
        sideMenuMarginBottom.constant = KKUtil.ConvertSizeByDensity(size: 25)
        sideMenuMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 15)
        
        backContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        contentViewMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 35)
        
        sideMenuTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        
        contentContainer.isHidden = true
        lblBack.text = KKUtil.languageSelectedStringForKey(key: "announcement_back")
        lblBack.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblBack.textColor = UIColor.spade_blue_5CB5DE
    }
    
    ///Button Actions
    @IBAction func btnCloseDidPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnBackDidPressed(){
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        bonusCollectionView.isHidden = false
        contentContainer.isHidden = true
    }
    
    ///Side Menu Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.bonusTVCIdentifier, for: indexPath) as? KKBonusMenuTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        if (selectedMenuItem == indexPath.row){
            cell.imgHover.isHidden = false
        } else {
            cell.imgHover.isHidden = true
        }
        
        cell.lblMenuName.text = sideMenuItem[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMenuItem = indexPath.row
        tableView.reloadData()
        
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
        bonusCollectionView.isHidden = false
        contentContainer.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 40)
    }
    
    ///Bonus Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.bonusItemCVCIdentifier, for: indexPath) as? KKBonusItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bonusCollectionView.isHidden = true
        contentContainer.isHidden = false
        
        let vc: KKBaseViewController = KKBonusContentViewController()
        vc.tableContentView = contentView
        vc.displayViewController = self
        vc.view.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentView.addSubview(vc.view)
        self.addChild(vc)
    }
}
