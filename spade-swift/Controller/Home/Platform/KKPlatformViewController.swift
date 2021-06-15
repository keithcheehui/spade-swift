//
//  KKPlatformViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 14/06/2021.
//

import UIKit

class KKPlatformViewController: KKBaseViewController {

    @IBOutlet weak var gameCollectionView: UICollectionView!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    
    enum itemType: String {
        case product = "Product"
        case gameType = "Game type"
    }
    
    var platformCode: String? = ""
    var gameListArray: [KKPlatformProductDetails]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        initFlowLayout()
        
        if (!platformCode!.isEmpty){
            getProductList(pCode: platformCode)
        }
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        headerContainerMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 20 : 30)
    }
    
    func initFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = KKUtil.ConvertSizeByDensity(size: 40)
        flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: 40)

        let size = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 130 : 140)

        if (KKUtil.isSmallerPhone()){
            flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        } else {
            flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 20)
        }
        
        flowLayout.itemSize = CGSize(width: size, height: size)

        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.register(UINib(nibName: "KKSingleRowGameItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.gameItemCVCIdentifier)
    }
    
    func getProductList(pCode: String? = "") {
        self.showAnimatedLoader()
        
        KKApiClient.getAllPlatformProduct(gCode: "", gameTypeCode: pCode!).execute { groupPlatformResponse in
            
            self.hideAnimatedLoader()
            self.gameListArray = groupPlatformResponse.results!.products!
            self.gameCollectionView.reloadData()
            
        } onFailure: { errorMessage in

            self.hideAnimatedLoader()
            self.showAlertView(alertMessage: "Api Error. Currently api is updating")
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension KKPlatformViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameListArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.gameItemCVCIdentifier, for: indexPath) as? KKSingleRowGameItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.imgGameImage.setUpImage(with: gameListArray[indexPath.item].img)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: PUT Web view for game redirect url
    }
}
