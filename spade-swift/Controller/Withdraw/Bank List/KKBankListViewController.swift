//
//  KKBankListViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/05/2021.
//

import Foundation
import UIKit

class KKBankListViewController: KKBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var bankTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLayout()
    }
    
    func initialLayout(){
        bankTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        bankTableView.register(UINib(nibName: "KKBankTableCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.bankTVCIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.bankTVCIdentifier, for: indexPath) as? KKBankTableCell
        else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        if (indexPath.row == 0) {
            cell.containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            cell.lblBankName.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))

            cell.lblBankName.text = KKUtil.languageSelectedStringForKey(key: "withdraw_add_bank")
            cell.lblBankAccount.isHidden = true
            cell.imgBank.image = UIImage(named: "ic_add")
        } else {
            cell.containerView.layer.borderWidth = 0

            cell.lblBankName.text = "Maybank Berhad Maybank"
            cell.lblBankAccount.text = "1111 **** **** 0000"
            cell.lblBankAccount.isHidden = false
        }
        
        
        cell.imgSelected.isHidden = true
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let viewController = KKAddBankViewController.init()
            viewController.view.frame = CGRect(x: 0, y: 0, width: tableContentView.frame.width, height: tableContentView.frame.height)
            tableContentView.addSubview(viewController.view)
            displayViewController.addChild(viewController)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKUtil.ConvertSizeByDensity(size: 45)
    }
}

