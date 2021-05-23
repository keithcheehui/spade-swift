//
//  KKFaqViewController.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 09/05/2021.
//

import Foundation
import UIKit

class KKFaqViewController: KKBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var faqTableView: UITableView!

    var sections = ["FAQ Section 1", "FAQ Section 2", "FAQ Section 3"]
    var itemsInSections = [
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vulputate, lorem a blandit fermentum, neque lacus pulvinar orci, et scelerisque leo magna id urna. Mauris vitae malesuada ex. Aliquam interdum lorem eu libero ullamcorper condimentum. Donec et maximus urna, a suscipit lectus. Duis consequat nulla eu sem aliquam, sit amet mattis magna porttitor. Nullam nunc eros, posuere sit amet sodales a, mattis id velit. Cras et rhoncus ligula, id tristique nulla. Vestibulum vitae augue lacus. Cras sit amet diam a libero efficitur tempor eu a justo. Donec eget quam vitae sapien consectetur varius. Sed justo diam, ultricies finibus convallis eu, sollicitudin at tortor. Donec posuere tortor ligula, sed mattis libero sodales ut. Donec sed egestas ipsum, ac ornare lectus. Nulla faucibus ut odio quis imperdiet. Aenean porta eu leo vel tristique. Lorem ipsum dolor sit amet, consectetur adipiscing elit."],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vulputate, lorem a blandit fermentum, neque lacus pulvinar orci, et scelerisque leo magna id urna. Mauris vitae malesuada ex."],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vulputate, lorem a blandit fermentum, neque lacus pulvinar orci, et scelerisque leo magna id urna. Mauris vitae malesuada ex. Aliquam interdum lorem eu libero ullamcorper condimentum. Donec et maximus urna, a suscipit lectus. Duis consequat nulla eu sem aliquam, sit amet mattis magna porttitor. Nullam nunc eros, posuere sit amet sodales a, mattis id velit. Cras et rhoncus ligula, id tristique nulla. Vestibulum vitae augue lacus. Cras sit amet diam a libero efficitur tempor eu a justo."]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faqTableView.backgroundColor = UIColor(white: 0, alpha: 0)
        faqTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let imageView = UIImageView()
        imageView.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 20), y: 2, width: KKUtil.ConvertSizeByDensity(size: 26), height: KKUtil.ConvertSizeByDensity(size: 26))
        imageView.image = UIImage(named: "bg_numbering")

        let numberLabel = UILabel()
        numberLabel.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 20), y: 5, width: KKUtil.ConvertSizeByDensity(size: 26), height: KKUtil.ConvertSizeByDensity(size: 20))
        numberLabel.textColor = UIColor.black
        numberLabel.backgroundColor = UIColor.clear
        numberLabel.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        numberLabel.textAlignment = NSTextAlignment.center
        numberLabel.text = String(format: "%02d", section + 1)
        
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: KKUtil.ConvertSizeByDensity(size: 60), y: 0, width: self.view.frame.size.width, height: KKUtil.ConvertSizeByDensity(size: 30))
        headerLabel.textColor = UIColor.white
        headerLabel.numberOfLines = 0
        headerLabel.backgroundColor = UIColor.clear
        headerLabel.font = UIFont.boldSystemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))
        headerLabel.text = sections[section]

        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: KKUtil.ConvertSizeByDensity(size: 30))
        headerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        headerView.addSubview(imageView)
        headerView.addSubview(numberLabel)
        headerView.addSubview(headerLabel)

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return KKUtil.ConvertSizeByDensity(size: 30)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        let cellText = itemsInSections[indexPath.section][0]
        cell.textLabel?.text = cellText
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: KKUtil.ConvertSizeByDensity(size: 12))

        cell.selectionStyle = .none

        return cell
    }
}
