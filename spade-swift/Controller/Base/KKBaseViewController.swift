//
//  KKBaseViewController.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
import Kingfisher

class KKBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var activityIndicator:      UIActivityIndicatorView!
    var tableContentView:       UIView!
    var displayViewController:  KKBaseViewController!
    var selectedGameType: Int = 0
    
    var pickerView: UIPickerView = UIPickerView()
    var datePickerView: UIDatePicker = UIDatePicker()
    var pickerToolBarView: UIToolbar = UIToolbar()
    
    var pickerTimeArray: [String] = [KKUtil.languageSelectedStringForKey(key: "picker_fd_td"),
                               KKUtil.languageSelectedStringForKey(key: "picker_fd_yd"),
                               KKUtil.languageSelectedStringForKey(key: "picker_fd_tm"),
                               KKUtil.languageSelectedStringForKey(key: "picker_fd_lm"),
                               KKUtil.languageSelectedStringForKey(key: "picker_fd_l90d")]
    
    var pickerStatusArray: [String] = [KKUtil.languageSelectedStringForKey(key: "picker_ws_all"),
                                       KKUtil.languageSelectedStringForKey(key: "picker_ws_approved"),
                                       KKUtil.languageSelectedStringForKey(key: "picker_ws_rejected"),
                                       KKUtil.languageSelectedStringForKey(key: "picker_ws_pending")]

    var dataArray: [String] = []
    var pickerTextField: UITextField!
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
        
        self.setupPickerView()
        self.setupDatePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
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
    func showPickerView(optionList: [String]) {
        dataArray = optionList
        pickerView.isHidden = false
    }
    
    //MARK:- Date Picker View
    func setupDatePickerView() {
        datePickerView.date = Date()
        datePickerView.locale = .current
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)

        if let window = UIApplication.shared.keyWindow {
            window.addSubview(datePickerView)
        }
        
        datePickerView.isHidden = true
    }
    
    //MARK:- Show Date Picker View
    func showDatePickerView() {
        datePickerView.isHidden = false
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
    
    func showAlertView(alertMessage: String) {
        
        if alertMessage.contains("connection") && alertMessage.contains("offline") {
            
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_internet_connection"),
                                           body: KKUtil.languageSelectedStringForKey(key: "error_internet_connection_desc"),
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
        else if alertMessage.contains("internal server error") {
            
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_internal_server_error"),
                                           body: KKUtil.languageSelectedStringForKey(key: "error_internal_server_error_desc"),
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
        else if (alertMessage.contains("invalid_grant") || alertMessage.contains("Invalid password")) {
            
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_invalid_credential"),
                                           body: KKUtil.languageSelectedStringForKey(key: "error_invalid_credential_desc"),
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
        else
        {
            self.showPopUpWithSingleButton(title: KKUtil.languageSelectedStringForKey(key: "error_error_encountered"),
                                           body: alertMessage,
                                           buttonTitle: KKUtil.languageSelectedStringForKey(key: "error_okay"))
        }
    }
    
    func showPopUpWithSingleButton(title: String, body: String, buttonTitle: String) {
        
        let alertView = KKCustomAlertViewController.init(title: title, body: body, buttonTitle: buttonTitle)
        self.present(alertView, animated: true, completion: nil)
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
    
    func addCurrencyFormat() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = ","
        
        let number = NumberFormatter().number(from: self)!
        return formatter.string(from: number)!
    }
    
    func isValidEmail() -> Bool {
            // here, `try!` will always succeed because the pattern is valid
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    
    var bankAccountMasked: String {
        self.enumerated().map({ (index, ch) in
            if index < 5 {
                return String(ch)
            }
            
            return "* "
        }).joined()
      }
    
//    var bankAccountMasked: String {
//        self.enumerated().map({ (index, ch) in
//            if index > self.count - 5 {
//                return String(ch)
//            }
//
//            return "* "
//        }).joined()
//      }
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
        
        let row = dataArray[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if dataArray.isEmpty {
            pickerTextField.text = ""
        } else {
            pickerTextField.text = dataArray[row]
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
