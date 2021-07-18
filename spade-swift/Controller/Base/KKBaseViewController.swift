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
    
    var pickerGenderArray: [PickerDetails] = []

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
        
        self.setupGenderOptions()
        self.setupPickerView()
        self.setupDatePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
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
        pickerView.selectRow(0, inComponent: 0, animated: false)
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

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
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

public enum Model : String {

    //Simulator
    case simulator     = "simulator/sandbox",

    //iPod
    iPod1              = "iPod 1",
    iPod2              = "iPod 2",
    iPod3              = "iPod 3",
    iPod4              = "iPod 4",
    iPod5              = "iPod 5",
    iPod6              = "iPod 6",
    iPod7              = "iPod 7",

    //iPad
    iPad2              = "iPad 2",
    iPad3              = "iPad 3",
    iPad4              = "iPad 4",
    iPadAir            = "iPad Air ",
    iPadAir2           = "iPad Air 2",
    iPadAir3           = "iPad Air 3",
    iPadAir4           = "iPad Air 4",
    iPad5              = "iPad 5", //iPad 2017
    iPad6              = "iPad 6", //iPad 2018
    iPad7              = "iPad 7", //iPad 2019
    iPad8              = "iPad 8", //iPad 2020

    //iPad Mini
    iPadMini           = "iPad Mini",
    iPadMini2          = "iPad Mini 2",
    iPadMini3          = "iPad Mini 3",
    iPadMini4          = "iPad Mini 4",
    iPadMini5          = "iPad Mini 5",

    //iPad Pro
    iPadPro9_7         = "iPad Pro 9.7\"",
    iPadPro10_5        = "iPad Pro 10.5\"",
    iPadPro11          = "iPad Pro 11\"",
    iPadPro2_11        = "iPad Pro 11\" 2nd gen",
    iPadPro3_11        = "iPad Pro 11\" 3nd gen",
    iPadPro12_9        = "iPad Pro 12.9\"",
    iPadPro2_12_9      = "iPad Pro 2 12.9\"",
    iPadPro3_12_9      = "iPad Pro 3 12.9\"",
    iPadPro4_12_9      = "iPad Pro 4 12.9\"",
    iPadPro5_12_9      = "iPad Pro 5 12.9\"",

    //iPhone
    iPhone4            = "iPhone 4",
    iPhone4S           = "iPhone 4S",
    iPhone5            = "iPhone 5",
    iPhone5S           = "iPhone 5S",
    iPhone5C           = "iPhone 5C",
    iPhone6            = "iPhone 6",
    iPhone6Plus        = "iPhone 6 Plus",
    iPhone6S           = "iPhone 6S",
    iPhone6SPlus       = "iPhone 6S Plus",
    iPhoneSE           = "iPhone SE",
    iPhone7            = "iPhone 7",
    iPhone7Plus        = "iPhone 7 Plus",
    iPhone8            = "iPhone 8",
    iPhone8Plus        = "iPhone 8 Plus",
    iPhoneX            = "iPhone X",
    iPhoneXS           = "iPhone XS",
    iPhoneXSMax        = "iPhone XS Max",
    iPhoneXR           = "iPhone XR",
    iPhone11           = "iPhone 11",
    iPhone11Pro        = "iPhone 11 Pro",
    iPhone11ProMax     = "iPhone 11 Pro Max",
    iPhoneSE2          = "iPhone SE 2nd gen",
    iPhone12Mini       = "iPhone 12 Mini",
    iPhone12           = "iPhone 12",
    iPhone12Pro        = "iPhone 12 Pro",
    iPhone12ProMax     = "iPhone 12 Pro Max",

    // Apple Watch
    AppleWatch1         = "Apple Watch 1gen",
    AppleWatchS1        = "Apple Watch Series 1",
    AppleWatchS2        = "Apple Watch Series 2",
    AppleWatchS3        = "Apple Watch Series 3",
    AppleWatchS4        = "Apple Watch Series 4",
    AppleWatchS5        = "Apple Watch Series 5",
    AppleWatchSE        = "Apple Watch Special Edition",
    AppleWatchS6        = "Apple Watch Series 6",

    //Apple TV
    AppleTV1           = "Apple TV 1gen",
    AppleTV2           = "Apple TV 2gen",
    AppleTV3           = "Apple TV 3gen",
    AppleTV4           = "Apple TV 4gen",
    AppleTV_4K         = "Apple TV 4K",
    AppleTV2_4K        = "Apple TV 4K 2gen",

    unrecognized       = "?unrecognized?"
}

// #-#-#-#-#-#-#-#-#-#-#-#-#
// MARK: UIDevice extensions
// #-#-#-#-#-#-#-#-#-#-#-#-#

public extension UIDevice {
    
  static let modelName: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    func mapToDevice(identifier: String) -> String {
      #if os(iOS)
      switch identifier {
      case "iPod5,1":                                 return "iPod Touch 5"
      case "iPod7,1":                                 return "iPod Touch 6"
      case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
      case "iPhone4,1":                               return "iPhone 4s"
      case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
      case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
      case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
      case "iPhone7,2":                               return "iPhone 6"
      case "iPhone7,1":                               return "iPhone 6 Plus"
      case "iPhone8,1":                               return "iPhone 6s"
      case "iPhone8,2":                               return "iPhone 6s Plus"
      case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
      case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
      case "iPhone8,4":                               return "iPhone SE"
      case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
      case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
      case "iPhone10,3", "iPhone10,6":                return "iPhone X"
      case "iPhone11,2":                              return "iPhone XS"
      case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
      case "iPhone11,8":                              return "iPhone XR"
      case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
      case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
      case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
      case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
      case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
      case "iPad6,11", "iPad6,12":                    return "iPad 5"
      case "iPad7,5", "iPad7,6":                      return "iPad 6"
      case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
      case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
      case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
      case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
      case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
      case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
      case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
      case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
      case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
      case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
      case "AppleTV5,3":                              return "Apple TV"
      case "AppleTV6,2":                              return "Apple TV 4K"
      case "AudioAccessory1,1":                       return "HomePod"
      case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
      default:                                        return identifier
      }
      #elseif os(tvOS)
      switch identifier {
      case "AppleTV5,3": return "Apple TV 4"
      case "AppleTV6,2": return "Apple TV 4K"
      case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
      default: return identifier
      }
      #endif
    }
    
    return mapToDevice(identifier: identifier)
  }()
}
