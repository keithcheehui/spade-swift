//
//  KKFaqViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 09/05/2021.
//

import Foundation
import UIKit
import WebKit

class KKFaqViewController: KKBaseViewController {
    
    @IBOutlet weak var faqTableView: UITableView!
    @IBOutlet weak var faqWebView: WKWebView!

    var faqArray: [KKFAQDetails]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCustomerFAQ()
        
//        faqTableView.backgroundColor = UIColor(white: 0, alpha: 0)
//        faqTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        faqTableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        faqTableView.reloadData()
    }
    
    //MARK:- API Calls
    
    func getCustomerFAQ() {
                
        KKApiClient.getCustomerFAQ().execute { [self] FAQResponse in
            
            self.faqArray = FAQResponse.results?.faqs
//            self.faqTableView.reloadData()
            
            if !faqArray[0].content!.isEmpty {
                faqWebView.loadHTMLString(faqArray[0].content!, baseURL: nil)
            }

        } onFailure: { errorMessage in
            self.showAlertView(alertMessage: "Api Error. Currently api is updating")
        }
    }
}

//extension KKFaqViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return faqArray.count
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let imageView = UIImageView()
//        imageView.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 20), y: 2, width: KKUtil.ConvertSizeByDensity(size: 26), height: KKUtil.ConvertSizeByDensity(size: 26))
//        imageView.image = UIImage(named: "bg_numbering")
//
//        let numberLabel = UILabel()
//        numberLabel.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 20), y: 5, width: KKUtil.ConvertSizeByDensity(size: 26), height: KKUtil.ConvertSizeByDensity(size: 20))
//        numberLabel.textColor = UIColor.black
//        numberLabel.backgroundColor = UIColor.clear
//        numberLabel.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
//        numberLabel.textAlignment = NSTextAlignment.center
//        numberLabel.text = String(format: "%02d", section + 1)
//
//        let headerLabel = UILabel()
//        headerLabel.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 60), y: 0, width: self.view.frame.size.width, height: KKUtil.ConvertSizeByDensity(size: 30))
//        headerLabel.textColor = UIColor.white
//        headerLabel.numberOfLines = 0
//        headerLabel.backgroundColor = UIColor.clear
//        headerLabel.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
//        headerLabel.text = faqArray[section].title
//
//        let headerView = UIView()
//        headerView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: KKUtil.ConvertSizeByDensity(size: 30))
//        headerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
//        headerView.addSubview(imageView)
//        headerView.addSubview(numberLabel)
//        headerView.addSubview(headerLabel)
//
//        return headerView
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        return KKUtil.ConvertSizeByDensity(size: 30)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
//        let cellText = faqArray[indexPath.section].content
//        cell.textLabel?.text = cellText
//        cell.textLabel?.textColor = UIColor.white
//        cell.textLabel?.numberOfLines = 0
//        cell.backgroundColor = UIColor.clear
//        cell.textLabel?.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
//
//        cell.selectionStyle = .none
//
//        return cell
//    }
//}
