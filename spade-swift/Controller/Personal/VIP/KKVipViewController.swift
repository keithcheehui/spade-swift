//
//  KKVipViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 11/07/2021.
//

import UIKit

class KKVipViewController: KKBaseViewController {

    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    
    var vipArray: [KKVipResults]! = []
    let size = KKUtil.ConvertSizeByDensity(size: 320)

    override func viewDidLoad() {
        super.viewDidLoad()
        initialLayout()
        initialFlowLayout()
        getVipLevelAPI()
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
    }
    
    func initialFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: size * 0.6, height: size)
        
        contentCollectionView.collectionViewLayout = flowLayout
        contentCollectionView.register(UINib(nibName: "KKVipItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.vipItemCVCIdentifier)
    }
    
    func getVipLevelAPI() {
        self.showAnimatedLoader()
        KKApiClient.getVipLevel().execute{ response in
            self.vipArray = response.results
            self.contentCollectionView.reloadData()
            self.hideAnimatedLoader()
        } onFailure: { errorMessage in
            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension KKVipViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vipArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.vipItemCVCIdentifier, for: indexPath) as? KKVipItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        let item = vipArray[indexPath.item]
        
        cell.containerView.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        cell.imgVip.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 8)
        cell.imgVip.layer.masksToBounds = true
        cell.imgVip.clipsToBounds = true
        cell.imgVip.setUpImage(with: item.img)
        
        if let isCurrentLevel = item.isCurrentLevel, isCurrentLevel {
            cell.containerView.layer.borderWidth = 2
            cell.containerView.layer.borderColor = UIColor.spade_yellow_F9F53B.cgColor
            cell.containerViewMarginTop.constant = 0
        } else {
            cell.containerView.layer.borderWidth = 0
            cell.containerView.layer.borderColor = UIColor.clear.cgColor
            cell.containerViewMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 10)
        }
        
        cell.containerViewMarginBottom.constant = cell.containerViewMarginTop.constant
        cell.containerViewMarginLeft.constant = cell.containerViewMarginTop.constant
        cell.containerViewMarginRight.constant = cell.containerViewMarginTop.constant
        
        var width = size * 0.6
        if let isCurrentLevel = item.isCurrentLevel {
            if !isCurrentLevel {
                width = size * 0.6 - (cell.containerViewMarginLeft.constant * 2)
            }
        }
        
        if let labelItems = item.detail {
            let total = labelItems.count
            let fontHeight = KKUtil.ConvertSizeByDensity(size: 24)
            var startY: CGFloat = 0.0

            for (index, detail) in labelItems.enumerated() {
                let view = UIView()
                if (index >= total - 2) {
                    view.backgroundColor = .spade_blue_2C336D
                } else {
                    view.backgroundColor = .clear
                }
                
                if (index >= total - 1) {
                    view.maskedCornersWidthRadius(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: KKUtil.ConvertSizeByDensity(size: 8))
                }
                
                let label1 = UILabel()
                label1.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
                label1.textColor = .spade_white_FFFFFF
                label1.text = detail.label
                view.addSubview(label1)
                
                let label2 = UILabel()
                label2.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 8))
                label2.textColor = .spade_white_FFFFFF
                label2.textAlignment = .right
                label2.text = detail.value
                view.addSubview(label2)
                
                let label2Width = width * 0.3
                let startX = width - label2Width - ConstantSize.paddingSecondaryHalf
                label2.frame = CGRect(x: startX, y: 0, width: label2Width, height: fontHeight)
                label1.frame = CGRect(x: ConstantSize.paddingSecondaryHalf, y: 0, width: width - label2Width - ConstantSize.paddingSecondaryHalf * 2, height: fontHeight)
                view.frame = CGRect(x: 0, y: startY, width: width, height: fontHeight + KKUtil.ConvertSizeByDensity(size: 1))
                startY += fontHeight - KKUtil.ConvertSizeByDensity(size: 0.5)
                cell.labelView.addSubview(view)
            }
        }
        
        return cell
    }
}

