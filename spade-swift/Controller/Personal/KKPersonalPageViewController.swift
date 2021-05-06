//
//  KKPersonalPageViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 29/04/2021.
//

import UIKit

class KKPersonalPageViewController: KKBaseViewController {
    
    enum TableViewRow: Int {
        
        case userInfoRow                   = 0
        case bettingRecordRow              = 1
        case accountDetailsRow             = 2
        case individualReportRow           = 3
    }
    
    struct ViewConstant {
        
        static let sideMenuYPos                 = CGFloat(40)
        static let sideMenuWidth                = CGFloat(150)
        static let pageViewControllerTopPadding = CGFloat(10)
        static let pageViewControllerPadding    = CGFloat(20)
    }
    
    var pageViewController:             UIPageViewController!
    var bgImageView:                    UIImageView!
    var sideMenuTableView:              UITableView!
    var contentImageView:               UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpOverallView()
    }
    
    func setUpOverallView() {
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0)
        var x = KKUtil.hasTopNotch() ? ScreenSize.leftNotchWidth : 0.0

        bgImageView = UIImageView.init()
        bgImageView.image = UIImage(named: "bg_mini_games")
        bgImageView.contentMode = .scaleToFill
        bgImageView.frame = self.view.frame
        self.view.addSubview(bgImageView)
        
        contentImageView = UIImageView.init()
        contentImageView.image = UIImage(named: "bg_box")
        contentImageView.contentMode = .scaleToFill
        contentImageView.isUserInteractionEnabled = true
        contentImageView.frame = CGRect(x: x + ViewConstant.sideMenuWidth + ViewConstant.pageViewControllerPadding,
                                               y: ScreenSize.navBarHeight + ViewConstant.pageViewControllerTopPadding,
                                               width: ScreenSize.width - (ScreenSize.leftNotchWidth + ViewConstant.sideMenuWidth + ViewConstant.pageViewControllerPadding*2),
                                               height: ScreenSize.height - (ScreenSize.navBarHeight + ViewConstant.pageViewControllerTopPadding))
        self.view.addSubview(contentImageView)
                
        sideMenuTableView = UITableView.init()
        sideMenuTableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_sidemenu")!)
        sideMenuTableView.showsVerticalScrollIndicator = false
        sideMenuTableView.estimatedRowHeight = CGFloat(0)
        sideMenuTableView.estimatedSectionHeaderHeight = CGFloat(0)
        sideMenuTableView.estimatedSectionFooterHeight = CGFloat(0)
        sideMenuTableView.isScrollEnabled = false
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        sideMenuTableView.frame = CGRect(x: x, y: ViewConstant.sideMenuYPos, width: ViewConstant.sideMenuWidth, height: ScreenSize.height - ViewConstant.sideMenuYPos)
        self.view.addSubview(sideMenuTableView)
        
        let headerImageView = UIImageView.init()
        headerImageView.image = UIImage(named: "bg_header")
        headerImageView.contentMode = .scaleAspectFit
        headerImageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.navBarHeight)
        self.view.addSubview(headerImageView)
    }
}

extension KKPersonalPageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init()
        headerView.backgroundColor = .clear
        headerView.frame = CGRect(x: 0, y: 0, width: ViewConstant.sideMenuWidth, height: 30)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let FooterView = UIView.init()
        FooterView.backgroundColor = .clear
        FooterView.frame = CGRect(x: 0, y: 0, width: ViewConstant.sideMenuWidth, height: 0.01)
        
        return FooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return CGFloat(0.01)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var sideMenuCell: KKSideMenuTableViewCell? = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.sideMenuTableCellIdentifier) as? KKSideMenuTableViewCell
        
        if (sideMenuCell == nil) {
            
            sideMenuCell = KKSideMenuTableViewCell.init(style: .default, reuseIdentifier: CellIdentifier.sideMenuTableCellIdentifier)
        }
        
        switch indexPath.row {
        
        case TableViewRow.userInfoRow.rawValue:
            sideMenuCell?.setUpSideMenuTitleWithIcon(iconImage: UIImage(named: "ic_user_info")!, titleString: KKUtil.languageSelectedStringForKey(key: "personal_user_info"))
            break
            
        case TableViewRow.bettingRecordRow.rawValue:
            sideMenuCell?.setUpSideMenuTitleWithIcon(iconImage: UIImage(named: "ic_betting_record")!, titleString: KKUtil.languageSelectedStringForKey(key: "personal_betting_record"))
            break
            
        case TableViewRow.accountDetailsRow.rawValue:
            sideMenuCell?.setUpSideMenuTitleWithIcon(iconImage: UIImage(named: "ic_account_detail")!, titleString: KKUtil.languageSelectedStringForKey(key: "personal_account_detail"))
            break
            
        case TableViewRow.individualReportRow.rawValue:
            sideMenuCell?.setUpSideMenuTitleWithIcon(iconImage: UIImage(named: "ic_report")!, titleString: KKUtil.languageSelectedStringForKey(key: "personal_individual_report"))
            break
            
        default:
            break
        
        }
        
        sideMenuCell?.selectionStyle = .none
        return sideMenuCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return KKSideMenuTableViewCell.calculateSideMenuHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.willMove(toParent: nil)
        
        for subview in contentImageView.subviews {
            
            contentImageView.willRemoveSubview(subview)
        }
        
        if (indexPath.row == 0) {
            let viewController = KKOnBoardingViewController.init()
            viewController.view.frame = CGRect(x: 0, y: 0, width: contentImageView.frame.width, height: contentImageView.frame.height)
            contentImageView.addSubview(viewController.view)
            self.addChild(viewController)
        }
        else
        {
            let viewController = KKTestPageViewController.init()
            viewController.view.frame = CGRect(x: 0, y: 0, width: contentImageView.frame.width, height: contentImageView.frame.height)
            contentImageView.addSubview(viewController.view)
            self.addChild(viewController)
        }
    }
}

class KKTestingPageViewController: KKBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView.init()
        view.backgroundColor = .systemTeal
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(view)
        
        let navBarBackBtn = UIButton.init()
        navBarBackBtn.contentMode = .scaleAspectFill
        navBarBackBtn.backgroundColor = .systemYellow
        navBarBackBtn.frame = CGRect(x: 0, y: ScreenSize.statusBarHeight, width: ConstantSize.navBarBtnWidth, height: ScreenSize.navBarHeight)
        navBarBackBtn.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        view.addSubview(navBarBackBtn)
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func test() {
        print("123")
    }
}

class KKTestPageViewController: KKBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView.init()
        view.backgroundColor = .systemPink
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(view)
        
        let navBarBackBtn = UIButton.init()
        navBarBackBtn.contentMode = .scaleAspectFill
        navBarBackBtn.backgroundColor = .systemYellow
        navBarBackBtn.frame = CGRect(x: 0, y: ScreenSize.statusBarHeight, width: ConstantSize.navBarBtnWidth, height: ScreenSize.navBarHeight)
        navBarBackBtn.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.view.addSubview(navBarBackBtn)
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
