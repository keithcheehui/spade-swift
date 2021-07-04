//
//  KKGeneralPopUpTableViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 19/06/2021.
//

import UIKit

class KKGeneralPopUpTableViewController: KKBaseViewController {

    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var contentTableView: UITableView!

    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var tableMarginLeft: NSLayoutConstraint!
    @IBOutlet weak var tableMarginRight: NSLayoutConstraint!
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var imgCloseWidth: NSLayoutConstraint!
    @IBOutlet weak var titleMarginTop: NSLayoutConstraint!
    
    var nonCommissionGameArray = [
        ["918KISS", "Samurai"],
        ["Suncity2", "Shark"],
        ["AG Casino", "Blackjack"],
        ["Mega888", "Birds Animal"]
    ]
    
    var rebateDetailsArray = [
        ["2021-02-21", "KY", "10000", "0.01", "100.00"],
        ["2021-02-21", "AB", "10000", "0.01", "100.00"],
        ["2021-02-21", "KY", "10000", "0.01", "100.00"],
        ["2021-02-21", "AB", "10000", "0.01", "100.00"],
    ]
    
    var popupTableViewType: PopupTableViewType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialLayout()
        setUpContentTableView()
    }
    
    func initialLayout() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        containerWidth.constant = ConstantSize.ssoPopUpWidth
        containerHeight.constant = ConstantSize.ssoPopUpHeight
        titleMarginTop.constant = KKUtil.ConvertSizeByDensity(size: 25)
        titleHeight.constant = KKUtil.ConvertSizeByDensity(size: 20)
        imgCloseWidth.constant = KKUtil.ConvertSizeByDensity(size: 30)
        tableMarginLeft.constant = KKUtil.ConvertSizeByDensity(size: 15)
        tableMarginRight.constant = tableMarginLeft.constant

        if popupTableViewType == .NonCommGame {
            imgTitle.image = UIImage(named: "title_non_comm_game")
        } else if popupTableViewType == .NonRebateGame {
            imgTitle.image = UIImage(named: "title_non_rebate_game")
        } else if popupTableViewType == .RebateDetail {
            imgTitle.image = UIImage(named: "title_rebatedetails")
        }
    }
    
    func setUpContentTableView() {
        contentTableView.register(KKGeneralHeaderView.self, forHeaderFooterViewReuseIdentifier: CellIdentifier.generalHeaderViewIdentifier)
        contentTableView.register(KKGeneralTableViewCell.self, forCellReuseIdentifier: CellIdentifier.generalItemCellIdentifier)
        contentTableView.backgroundColor = .clear
        contentTableView.showsVerticalScrollIndicator = false
        contentTableView.estimatedRowHeight = CGFloat(0)
        contentTableView.estimatedSectionHeaderHeight = CGFloat(0)
        contentTableView.estimatedSectionFooterHeight = CGFloat(0)
        contentTableView.separatorStyle = .none
        contentTableView.clipsToBounds = true
        contentTableView.delegate = self
        contentTableView.dataSource = self
    }
    
    func returnCellDetails(indexPath: IndexPath) -> [String] {
        switch popupTableViewType {
        case .NonCommGame,
             .NonRebateGame:
            return nonCommissionGameArray[indexPath.row]
            
        case .RebateDetail:
            return rebateDetailsArray[indexPath.row]
            
        default:
            return []
        }
    }
    
    ///Button Actions
    @IBAction func btnBackDidPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension KKGeneralPopUpTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellIdentifier.generalHeaderViewIdentifier) as? KKGeneralHeaderView
        else {
            fatalError("dequeueReusableHeaderFooterView failed while casting")
        }
        
        headerView.setUpHeaderView(width: tableView.frame.size.width, type: popupTableViewType)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return KKGeneralHeaderView.calculateHeaderViewHeight()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0.01)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch popupTableViewType {
        
        case .NonCommGame,
             .NonRebateGame:
            return nonCommissionGameArray.count
            
        case .RebateDetail:
            return rebateDetailsArray.count
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.generalItemCellIdentifier, for: indexPath) as? KKGeneralTableViewCell
        else {
            fatalError("dequeueReusableCell failed while casting")
        }

        if indexPath.row % 2 == 1 {
            cell.cellView.backgroundColor = .spade_blue_4850C6
        } else {
            cell.cellView.backgroundColor = .clear
        }
        
        let cellDetails = self.returnCellDetails(indexPath: indexPath)
        cell.setUpCellDetails(width: tableView.frame.size.width, content: cellDetails)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return KKGeneralTableViewCell.calculateCellDetailsHeight()
    }
}
