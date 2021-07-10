//
//  KKBaseViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
import Kingfisher

class KKBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var activityIndicator: UIActivityIndicatorView!
    var tableContentView: UIView!
    var displayViewController: KKBaseViewController!
    var selectedGameType: Int = 0
    var selectedGroupCode = ""
    
    var pickerView: UIPickerView = UIPickerView()
    var datePickerView: UIDatePicker = UIDatePicker()
    var pickerToolBarView: UIToolbar = UIToolbar()
    
    var pickerTimeArray: [PickerDetails] = []
    var pickerStatusArray: [PickerDetails] = []
    var pickerGenderArray: [PickerDetails] = []
    var pickerTransTypeArray: [PickerDetails] = []

    var dataArray: [PickerDetails] = []
    var pickerTextField: UITextField!
    var selectedPickerItem: PickerDetails!
    var datePickerTextField: UITextField!

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        activityIndicator = UIActivityIndicatorView.init(style: .white)
        activityIndicator.alpha = CGFloat(0)
        activityIndicator.color = .spade_white_FFFFFF
        activityIndicator.backgroundColor = UIColor.spade_black_000000.withAlphaComponent(0.75)
        
        if tableContentView != nil {
            activityIndicator.frame = CGRect(x: 0, y: 0, width: tableContentView.frame.size.width, height: tableContentView.frame.size.height)
        } else {
            activityIndicator.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        }
        
        self.setupPickerTimeOptions()
        self.setupWithdrawStatusOptions()
        self.setupGenderOptions()
        self.setupTransTypeOptions()
        
        self.setupPickerView()
        self.setupDatePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupPickerTimeOptions() {
        pickerTimeArray.removeAll()
        
        var details = PickerDetails.init()
        for item in FilterDuration.allCases {
            switch item {
            case .all:
                details.id = ""
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_ws_all")
                
//            case .td:
//                details.id = item.rawValue
//                details.name = KKUtil.languageSelectedStringForKey(key: "picker_fd_td")
//
//            case .yd:
//                details.id = item.rawValue
//                details.name = KKUtil.languageSelectedStringForKey(key: "picker_fd_yd")
                
            case .l7d:
                details.id = item.rawValue
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_fd_l7d")
                
//            case .tm:
//                details.id = item.rawValue
//                details.name = KKUtil.languageSelectedStringForKey(key: "picker_fd_tm")
                
                
//            case .lm:
//                details.id = item.rawValue
//                details.name = KKUtil.languageSelectedStringForKey(key: "picker_fd_lm")
            
            case .l30d:
                details.id = item.rawValue
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_fd_l30d")

//            case .l90d:
//                details.id = item.rawValue
//                details.name = KKUtil.languageSelectedStringForKey(key: "picker_fd_l90d")
            }
           
            pickerTimeArray.append(details)
        }
    }
    
    func setupWithdrawStatusOptions() {
        pickerStatusArray.removeAll()
        
        var details = PickerDetails.init()
        for item in HistoryStatus.allCases {
            switch item {
            case .all:
                details.id = ""
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_ws_all_status")
                
            case .success:
                details.id = item.rawValue
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_ws_success")
                
            case .fail:
                details.id = item.rawValue
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_ws_fail")
                
                
            case .pending:
                details.id = item.rawValue
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_ws_pending")
            }
            pickerStatusArray.append(details)
        }
    }
    
    func setupGenderOptions() {
        pickerGenderArray.removeAll()
        
        var details = PickerDetails.init()
        for item in GenderType.allCases {
            switch item {
            case .male:
                details.id = item.rawValue
                details.name = item.rawValue
                
            case .female:
                details.id = item.rawValue
                details.name = item.rawValue
            }
            pickerGenderArray.append(details)
        }
    }
    
    func setupTransTypeOptions() {
        pickerTransTypeArray.removeAll()
        
        var details = PickerDetails.init()
        for item in TransactionType.allCases {
            switch item {
            case .all:
                details.id = ""
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_ws_all_type")
                
            case .collect:
                details.id = item.rawValue
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_type_collect")
                
                
            case .payout:
                details.id = item.rawValue
                details.name = KKUtil.languageSelectedStringForKey(key: "picker_type_payout")
            }
            pickerTransTypeArray.append(details)
        }
    }
    
    //MARK:- Picker View
    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        pickerToolBarView.barStyle = UIBarStyle.default
        pickerToolBarView.isTranslucent = true
        pickerToolBarView.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        let flexibleSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);

        pickerToolBarView.setItems([flexibleSpace2, flexibleSpace, doneButton], animated: false)
        pickerToolBarView.isUserInteractionEnabled = true

        if let window = UIApplication.shared.keyWindow {
            window.addSubview(pickerView)
        }
        
        pickerView.isHidden = true
    }
    
    //MARK:- Show Picker View
    func showPickerView(optionList: [PickerDetails]) {
        selectedPickerItem = nil
        dataArray = optionList
        pickerView.isHidden = false
    }
    
    //MARK:- Date Picker View
    func setupDatePickerView() {
        datePickerView.date = Date()
        datePickerView.locale = .current
        datePickerView.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePickerView.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(datePickerView)
        }
        
        datePickerView.isHidden = true
    }
    
    //MARK:- Show Date Picker View
    func showDatePickerView(showTime: Bool) {
        datePickerView.isHidden = false
        
        if (showTime) {
            datePickerView.locale = Locale(identifier: "en_GB")
            datePickerView.datePickerMode = .dateAndTime
        } else {
            datePickerView.datePickerMode = .date
        }
    }
    
    @objc func handleDateSelection(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: picker.date);

        datePickerTextField.text = dateString
    }
    
    //MARK:- Show/Hide Animation Loader
    func showAnimatedLoader() {
        
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: Double(0.25), delay: Double(0), options: .beginFromCurrentState, animations: {
            
            self.activityIndicator.alpha = CGFloat(1)
            
        }, completion: nil)
    }

    func hideAnimatedLoader() {
        
        self.view.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: Double(0.25), delay: Double(0), options: .beginFromCurrentState, animations: {
            
            self.activityIndicator.alpha = CGFloat(0)
            
        }, completion: { completed in
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        })
    }
    
    //MARK:- Alert View Setup
    
    func showAlertView(type: ToastType, alertMessage: String) {
        if (type == .Success) {
            self.showToastMessage(type: .Success, body: alertMessage)
        } else {
            if alertMessage.contains("connection") && alertMessage.contains("offline") {
                self.showToastMessage(type: .Error, body: KKUtil.languageSelectedStringForKey(key: "error_internet_connection_desc"))
            } else if alertMessage.contains("internal server error") {
                self.showToastMessage(type: .Error, body: KKUtil.languageSelectedStringForKey(key: "error_internal_server_error_desc"))
            }else if (alertMessage.contains("invalid_grant") || alertMessage.contains("Invalid password")) {
                self.showToastMessage(type: .Error, body: KKUtil.languageSelectedStringForKey(key: "error_invalid_credential_desc"))
            } else{
                self.showToastMessage(type: .Error, body: alertMessage)
            }
        }
    }
    
    func showToastMessage(type: ToastType, body: String) {
        
        let alertView = KKCustomToastViewController.init(toastType: type, msgDesc: body)
        self.present(alertView, animated: true, completion: nil)

        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alertView.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK:- General Method

    @objc func backBtnClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissBtnClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIDevice {
    
    var hasNotch: Bool {
        
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

extension String {
    
    var isBackspace: Bool {
        
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
    
//    var bankAccountMasked: String {
//        self.enumerated().map({ (index, ch) in
//            if index < 5 {
//                return String(ch)
//            }
//
//            return "* "
//        }).joined()
//      }
    
    var bankAccountMasked: String {
        self.enumerated().map({ (index, ch) in
            if index > self.count - 5 {
                return String(ch)
            }

            return "* "
        }).joined()
      }
}

extension UIImageView {
    
    func setUpImage(with url: String?, placeholder: UIImage? = UIImage(named: "img_placeholder")) {
        
        if let urlString = url, let urL = URL(string: urlString) {
                            
            self.kf.setImage(with: urL, placeholder: placeholder)
        }
        else if let image = placeholder
        {
            self.image = image
        }
    }
}

extension UIView {
    
    func startRotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = false
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func removeRotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.5
        rotation.isCumulative = false
        rotation.repeatCount = 1
        self.layer.add(rotation, forKey: "rotationAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            self.layer.removeAllAnimations()
        }
    }
    
    func maskedCornersWidthRadius(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}

extension KKBaseViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if dataArray.isEmpty {
            return 0
        }
        
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if dataArray.isEmpty {
            return ""
        }
        
        return dataArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if dataArray.isEmpty {
            return
        } else {
            pickerTextField.text = dataArray[row].name
            selectedPickerItem = dataArray[row]
        }
    }
}

extension KKBaseViewController: UIToolbarDelegate {

    @objc func didTapDone() {
        view.endEditing(true)
        pickerView.isHidden = true
    }

    @objc func didTapCancel() {
        view.endEditing(true)
        pickerView.isHidden = true
    }
}

extension UITextField {

    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

struct SideMenuDetails {
    
    var imgIcon: String
    var id: Int
    var title: String
    
    init(imgIcon: String = "", id: Int = 0, title: String = "") {
        self.imgIcon = imgIcon
        self.id = id
        self.title = title
    }
}

struct PickerDetails {
    
    var id: String
    var name: String
    
    init(id: String = "", name: String = "") {
        self.id = id
        self.name = name
    }
}

