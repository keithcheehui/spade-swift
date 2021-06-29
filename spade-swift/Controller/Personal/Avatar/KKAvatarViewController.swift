//
//  KKAvatarViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 29/06/2021.
//

import UIKit

class KKAvatarViewController: KKBaseViewController {

    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var imgTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var avatarCollectionViewMarginTop: NSLayoutConstraint!
    @IBOutlet weak var avatarCollectionViewMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var avatarCollectionViewMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var avatarCollectionViewMarginRight: NSLayoutConstraint!
    @IBOutlet weak var btnSaveContainerHeight: NSLayoutConstraint!

    var avatarList: [AvatarDetails] = []
    var selectedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        appendAvatarList()
        
        let size = KKUtil.ConvertSizeByDensity(size: 90)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: size, height: size)
        avatarCollectionView.collectionViewLayout = flowLayout

        avatarCollectionView.collectionViewLayout = flowLayout
        avatarCollectionView.register(UINib(nibName: "KKAvatarItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.avatarItemCVCIdentifier)
    }

    func initialLayout() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        containerWidth.constant = ConstantSize.ssoPopUpWidth
        containerHeight.constant = ConstantSize.ssoPopUpHeight
        imgTitleHeight.constant = KKUtil.ConvertSizeByDensity(size: 45)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        btnSaveContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 40)
        avatarCollectionViewMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 30)
        avatarCollectionViewMarginBottom.constant = avatarCollectionViewMarginTop.constant
        avatarCollectionViewMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 40)
        avatarCollectionViewMarginRight.constant = avatarCollectionViewMarginLeft.constant
    }
    
    func appendAvatarList() {
        avatarList.removeAll()
        
        var details = AvatarDetails.init()
        for n in 1...10 {
            details.img = String(format: "ic_avatar_%d", n)
            details.id = n
            
            avatarList.append(details)
        }
        
        avatarCollectionView.reloadData()
    }
    
    @IBAction func btnCloseDidPressed() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnSaveDidPressed() {
        self.dismiss(animated: false, completion: nil)
    }
}

struct AvatarDetails {
    
    var img: String
    var id: Int
    
    init(img: String = "", id: Int = 0) {
        self.img = img
        self.id = id
    }
}

extension KKAvatarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatarList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.avatarItemCVCIdentifier, for: indexPath) as? KKAvatarItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.imgAvatar.image = UIImage(named: avatarList[indexPath.item].img)

        if (selectedItem == indexPath.item){
            cell.imgBorder.image = UIImage(named: "ic_avatar_border_selected")
        } else {
            cell.imgBorder.image = UIImage(named: "ic_avatar_border")
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.item
        avatarCollectionView.reloadData()
    }
}
