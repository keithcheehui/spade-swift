//
//  KKPlatformViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 14/06/2021.
//

import UIKit

class KKPlatformViewController: KKBaseViewController {

    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var platformTableView: UITableView!
    @IBOutlet weak var lblPlatformName: UILabel!
    @IBOutlet weak var lblTotalGame: UILabel!

    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var txtSearch: UITextField!

    @IBOutlet weak var imgBackWidth: NSLayoutConstraint!
    @IBOutlet weak var headerContainerMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var platformTableViewWidth: NSLayoutConstraint!

    @IBOutlet weak var searchContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var searchContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var searchContainerMarginRight: NSLayoutConstraint!
   
    var platformCode: String? = ""
    var menuListArray: [KKGameTypeListing]! = []
    var gameListArray: [KKGameTypeItems]! = []
    var selectedMenuItem = 0
    var selectedPlatformId = ""
    var searchArray: [KKGameTypeItems]! = []
    var homeViewController: KKHomeViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
        initFlowLayout()
        
        if (!platformCode!.isEmpty){
            getGameTypeListingAPI(pCode: platformCode!)
        }
    }
    
    func initialLayout(){
        imgBackWidth.constant = ConstantSize.imgBackWidth
        headerContainerMarginLeft.constant = ConstantSize.headerContainerMarginLeft
        platformTableViewWidth.constant = KKUtil.ConvertSizeByDensity(size: 160)
        lblPlatformName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 24))
        lblPlatformName.textColor = .spade_white_FFFFFF
        lblTotalGame.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        lblTotalGame.textColor = .spade_white_FFFFFF
        
        searchContainerWidth.constant = KKUtil.ConvertSizeByDensity(size: 150)
        searchContainerHeight.constant = KKUtil.ConvertSizeByDensity(size: 30)
        searchContainerMarginRight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        searchContainer.backgroundColor = UIColor(white: 0, alpha: 0.5)
        searchContainer.layer.cornerRadius = KKUtil.ConvertSizeByDensity(size: 10)
        
        txtSearch.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        txtSearch.textColor = .spade_white_FFFFFF
        txtSearch.attributedPlaceholder = NSAttributedString(string: KKUtil.languageSelectedStringForKey(key: "platform_search_placeholder"), attributes: [NSAttributedString.Key.foregroundColor : UIColor.spade_grey_BDBDBD])
        txtSearch.delegate = self
        txtSearch.returnKeyType = .search
        txtSearch.addTarget(self, action: #selector(textfieldDidChange(_:)), for: .editingChanged)

        platformTableView.register(UINib(nibName: "KKSideMenuTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.sideMenuTVCIdentifier)
    }
    
    func initFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 25 : 25)
        flowLayout.minimumLineSpacing = KKUtil.ConvertSizeByDensity(size: 45)

        let insets = KKUtil.ConvertSizeByDensity(size: 20)
        flowLayout.sectionInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        
        flowLayout.itemSize = CGSize(width: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 100 : 110), height: KKUtil.ConvertSizeByDensity(size: KKUtil.isSmallerPhone() ? 120 : 130))

        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.register(UINib(nibName: "KKPlatfromGameItemCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifier.platformGameItemCVCIdentifier)
    }
    
    func getGameTypeListingAPI(pCode: String) {
        self.showAnimatedLoader()
        
        KKApiClient.getGameTypeListing(gCode: pCode).execute { groupPlatformResponse in
            
            self.hideAnimatedLoader()
            self.menuListArray = groupPlatformResponse.results!.gameTypeListing!
            self.gameListArray = self.menuListArray[self.selectedMenuItem].gameTypeItems!
            self.platformTableView.reloadData()
            self.gameCollectionView.reloadData()
            
            self.lblPlatformName.text = self.menuListArray[self.selectedMenuItem].name!
            self.lblTotalGame.text = String(format: KKUtil.languageSelectedStringForKey(key: "platform_total_game"), self.menuListArray[self.selectedMenuItem].gameTypeItems!.count)

            self.searchGame()
        } onFailure: { errorMessage in

            self.hideAnimatedLoader()
            self.showAlertView(type: .Error, alertMessage: errorMessage)
        }
    }
    
    func searchGame() {
        if (txtSearch.text!.isEmpty) {
            searchArray = gameListArray
        } else {
            searchArray = gameListArray.filter { $0.name!.lowercased().contains(txtSearch.text!.lowercased())}
//            let pattern = "\\b" + NSRegularExpression.escapedPattern(for: txtSearch.text!)
//            searchArray = gameListArray.filter {
//                $0.name!.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
//            }
        }
        
        gameCollectionView.reloadData()
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension KKPlatformViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.platformGameItemCVCIdentifier, for: indexPath) as? KKPlatfromGameItemCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.imgIcon.setUpImage(with: searchArray[indexPath.item].img)
        cell.lblName.text = searchArray[indexPath.item].name

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //TODO: PUT Web view for game redirect url
        if (KKUtil.isUserLogin()) {
            self.navigationController?.pushViewController(KKWebViewController(), animated: true)
        } else {
            homeViewController.showLoginPopup()
        }
    }
}

extension KKPlatformViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.sideMenuTVCIdentifier, for: indexPath) as? KKSideMenuTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        if (selectedMenuItem == indexPath.row){
            cell.imgHover.isHidden = false
        } else {
            cell.imgHover.isHidden = true
        }
        
        cell.imgIcon.setUpImage(with: menuListArray[indexPath.row].img2)
        cell.lblName.text = menuListArray[indexPath.row].name
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMenuItem = indexPath.row
        self.gameListArray = self.menuListArray[selectedMenuItem].gameTypeItems
        self.platformTableView.reloadData()
        self.gameCollectionView.reloadData()
        
        self.lblPlatformName.text = self.menuListArray[self.selectedMenuItem].name!
        self.lblTotalGame.text = String(format: KKUtil.languageSelectedStringForKey(key: "platform_total_game"), self.menuListArray[self.selectedMenuItem].gameTypeItems!.count)
        
        self.searchGame()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 50)
    }
}

extension KKPlatformViewController: UITextFieldDelegate {
    
    @objc func textfieldDidChange(_ sender: UITextField) {
        searchGame()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchGame()
        view.endEditing(true)
        return true
    }
}

