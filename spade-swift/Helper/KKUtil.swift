//
//  KKUtil.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
import KeychainSwift
import SystemConfiguration

class KKUtil: NSObject {
    
    ///Check internet connectivity
    class func isConnectedToInternet() ->Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {

            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {

                SCNetworkReachabilityCreateWithAddress(nil, $0)

            }

        }) else {

            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    ///Localization
    class func languageSelectedStringForKey (key: String) -> String {
        
        let path : String = Bundle.main.path(forResource: "en", ofType: "lproj")!

        let languageBundle = Bundle.init(path: path)
        let string : String = NSLocalizedString(key, tableName: "", bundle: languageBundle!, value: "", comment: "")

        return string

    }
    
    ///Check email validation
    class func isValidEmail(testStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    ///Check input validation
    class func isValidInput(testStr: String) -> Bool {
        let inputRegEx = "^.{6,12}$"
        let inputCheck = NSPredicate(format: "SELF MATCHES %@",inputRegEx)
        return inputCheck.evaluate(with: testStr)
    }
    
    ///Check password input validation
    class func isValidPasswordInput (testStr: String) -> Bool {
        let inputRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",inputRegEx)
        return passwordCheck.evaluate(with: testStr)
    }
    
    ///Get Label Height according to its text with font
    class func getLabelSize (text: String, maximumLabelSize: CGSize, attributes: [NSAttributedString.Key : Any]?) -> CGSize {
        
        let expectLabelSize = text.boundingRect(with: maximumLabelSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        return expectLabelSize
    }
    
    /// Add param for GET url
    class func addQueryParams(url: URL, parameters: [String: String]) -> URL? {

        var urlComponents = URLComponents.init(url: url, resolvingAgainstBaseURL: false)
        guard urlComponents != nil
        else {
            return nil
        }
        
        urlComponents?.setQueryItems(with: parameters)
        
        return urlComponents?.url
    }
    
    ///convert size according to the screen size
    class func ConvertSizeByDensity(size: CGFloat) -> CGFloat {
        return size * ScreenSize.minLength / 414.0
    }
    
    ///convert size according to the screen size
    class func isSmallerPhone() -> Bool {
        return ScreenSize.maxLength <= 812.0
    }
    
    class func hasTopNotch() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    ///logout user
    class func logOutUser() {
        KKApiClient.logOutUser().execute { res in
            cleanSet()
            KKUtil.proceedToPage(vc: KKSplashScreenViewController.init())
        } onFailure: { errorMessage in
            cleanSet()
            KKUtil.proceedToPage(vc: KKSplashScreenViewController.init())
        }
    }
    
    class func cleanSet() {
        UserDefaults.standard.set(false, forKey: CacheKey.loginStatus)
        UserDefaults.standard.set(nil, forKey: CacheKey.userProfile)
        UserDefaults.standard.set("", forKey: CacheKey.accessToken)
        UserDefaults.standard.set("", forKey: CacheKey.refreshToken)
        UserDefaults.standard.set(nil, forKey: CacheKey.selectedLanguage)
        UserDefaults.standard.set(nil, forKey: CacheKey.selectedCountry)

        KeychainSwift().set("", forKey: CacheKey.username)
        KeychainSwift().set("", forKey: CacheKey.secret)
        
        UserDefaults.standard.synchronize()
    }
    
    //MARK: APP VERSION
    ///encode app version
    class func encodeAppVersion(object: KKAppVersionResults?) {
        if object == nil {
            return
        }
        
        if let jsonString = try? JSONEncoder().encode(object) {
            let jsonStringData = String(data: jsonString, encoding: .utf8)!
            UserDefaults.standard.set(jsonStringData, forKey: CacheKey.appVersionDetails)
        }
        UserDefaults.standard.synchronize()
    }
    
    ///decode app version
    class func decodeAppVersionFromCache() -> KKAppVersionResults? {
        let jsonString = UserDefaults.standard.string(forKey: CacheKey.appVersionDetails)
        if (jsonString == nil || jsonString!.isEmpty) {
            return nil
        }
        
        do {
            let object = try JSONDecoder().decode(KKAppVersionResults.self, from: Data(jsonString!.utf8))
            return object
        } catch {
            return nil
        }
    }
    
    //MARK: USER PROFILE
    ///encode user profile
    class func encodeUserProfile(object: KKUserProfileDetails?) {
        if object == nil {
            return
        }
        
        if let jsonString = try? JSONEncoder().encode(object) {
            let jsonStringData = String(data: jsonString, encoding: .utf8)!
            UserDefaults.standard.set(jsonStringData, forKey: CacheKey.userProfile)
        }
        UserDefaults.standard.synchronize()
    }
    
    ///decode user profile
    class func decodeUserProfileFromCache() -> KKUserProfileDetails? {
        let jsonString = UserDefaults.standard.string(forKey: CacheKey.userProfile)
        if (jsonString == nil || jsonString!.isEmpty) {
            return nil
        }
        
        do {
            let object = try JSONDecoder().decode(KKUserProfileDetails.self, from: Data(jsonString!.utf8))
            return object
        } catch {
            return nil
        }
    }
    
    //MARK: USER COUNTRY
    ///encode user country
    class func encodeUserCountry(object: KKAppVersionCountries?) {
        if object == nil {
            return
        }
        
        if let jsonString = try? JSONEncoder().encode(object) {
            let jsonStringData = String(data: jsonString, encoding: .utf8)!
            UserDefaults.standard.set(jsonStringData, forKey: CacheKey.selectedCountry)
        }
        UserDefaults.standard.synchronize()
    }
    
    ///decode user country
    class func decodeUserCountryFromCache() -> KKAppVersionCountries {
        let defaultString = """
        {
            "code": "\(CountryCode.Malaysia)",
            "name": "Malaysia",
            "locale": "https://legend.fteg.dev/storage/upload/images/countries/malaysia.png",
            "country_calling_code": "60",
            "currency": "\(CurrencyCode.Malaysia)",
            "currency_name": "Malaysia Ringgit"
        }
        """
        
        let jsonString = UserDefaults.standard.string(forKey: CacheKey.selectedCountry)
        if (jsonString != nil) {
            do {
                let object = try JSONDecoder().decode(KKAppVersionCountries.self, from: Data(jsonString!.utf8))
                return object
            } catch {
                return try! JSONDecoder().decode(KKAppVersionCountries.self, from: Data(defaultString.utf8))
            }
        }
        
        if KKSingleton.sharedInstance.countryArray.count > 0 {
            return KKSingleton.sharedInstance.countryArray.first(where: {$0.currency == CurrencyCode.Malaysia})!
        } else {
            return try! JSONDecoder().decode(KKAppVersionCountries.self, from: Data(defaultString.utf8))
        }
    }
    
    //MARK: USER LANGUAGE
    ///encode user language
    class func encodeUserLanguage(object: KKAppVersionLanguages?) {
        if object == nil {
            return
        }
        
        if let jsonString = try? JSONEncoder().encode(object) {
            let jsonStringData = String(data: jsonString, encoding: .utf8)!
            UserDefaults.standard.set(jsonStringData, forKey: CacheKey.selectedLanguage)
        }
        UserDefaults.standard.synchronize()
    }
    
    ///decode user language
    class func decodeUserLanguageFromCache() -> KKAppVersionLanguages {
        let defaultString = """
        {
            "locale": "\(LocaleCode.English)",
            "name": "\(LocaleName.English)"
        }
        """
        
        let jsonString = UserDefaults.standard.string(forKey: CacheKey.selectedLanguage)
        if (jsonString != nil) {
            do {
                let object = try JSONDecoder().decode(KKAppVersionLanguages.self, from: Data(jsonString!.utf8))
                return object
            } catch {
                return try! JSONDecoder().decode(KKAppVersionLanguages.self, from: Data(defaultString.utf8))
            }
        }
        
        if KKSingleton.sharedInstance.countryArray.count > 0 {
            return KKSingleton.sharedInstance.languageArray.first(where: {$0.locale == LocaleCode.English})!
        } else {
            return try! JSONDecoder().decode(KKAppVersionLanguages.self, from: Data(defaultString.utf8))
        }
    }
    
    class func getHeaderTitleViaTableViewType(tableViewType: TableViewType) -> [String] {
        
        switch tableViewType {
        
            case .AffliateDownline:
                return ["ID", "Username", "Today's Bet", "Total Bet"]
                
            case .AffliateTurnover:
                return ["Date", "New Affliate Member", "Total Turnover", "Commission"]
                
            case .CommissionTransaction:
                return ["Time", "", "Amount"]
                
            case .ComissionTable:
                return ["Agent Level", "Team Performance", "Return Commission"]
        
            case .ManualRebate:
                return ["Game Type", "Valid Bet Amount", "Highest Rebate Ratio", "Rebate Amount"]
                
            case .RebateRecord:
                return ["Game Type", "Stack", "Rebate Amount", "Details"]
                
            case .RebateRatio:
                return ["Game Time", "Valid Bet Amount", "Rebate Percent", "Rebate Amount"]
                
            case .BettingRecord:
                return ["Bet Time", "Bet No", "Game Name", "Bet Amount", "Results"]
                
            case .AccountDetails:
                return ["Transaction Time", "Status", "Out", "In", "Balance"]
                
            case .DepositHistory:
                return ["Time", "Amount", "Payment Method", "Status", "Details"]
                
            case .WithdrawHistory:
                return ["Date & Time", "Withdraw ID", "Amount", "Withdrawal Method", "Status"]
        }
    }
    
    ///redirect to home page
    class func redirectToHome() {
        KKUtil.proceedToPage(vc: KKHomeViewController.init())
    }
    
    ///redirect user to home page
    class func proceedToPage(vc: KKBaseViewController) {
        let navigationController = UINavigationController.init(rootViewController: vc)
        
        if #available(iOS 13.0, *) {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                let scene = UIApplication.shared.connectedScenes.first
                if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                
                    sceneDelegate.changeRootViewController(viewController: navigationController)
                }
            })
        }
        else
        {
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
                        
            UIView.transition(with: window, duration: 0, options: .transitionCrossDissolve, animations: {
                let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
                appDelegate!.window?.rootViewController = navigationController
                
            }, completion: nil)
        }
    }
    
    class func addCurrencyFormat(value: Float) -> String {
        let valueStr = String(format: "%.02f", value)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = ","
        
        let number = NumberFormatter().number(from: valueStr)!
        return formatter.string(from: number)!
    }
}
