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
//        return NSLocalizedString(key, tableName: "", bundle: Bundle.main, value: "", comment: "")

    }
    
    ///Check email validation
    class func isValidEmail (testStr: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    ///Check input validation
    class func isValidInput (testStr: String) -> Bool {
        
        let inputRegEx = "{6,12}"
        
        let inputTest = NSPredicate(format:"SELF MATCHES %@", inputRegEx)
        return inputTest.evaluate(with: testStr)
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
        UserDefaults.standard.set(false, forKey: CacheKey.loginStatus)
        KeychainSwift().set("", forKey: CacheKey.accessToken)
        KeychainSwift().set("", forKey: CacheKey.refreshToken)
        KeychainSwift().set("", forKey: CacheKey.userProfile)

        UserDefaults.standard.synchronize()
        
        KKUtil.proceedToPage(vc: KKSplashScreenViewController.init())
    }
    
    ///decode app version
    class func decodeAppVersionFromCache() -> KKAppVersionResults? {
        
        if (KeychainSwift().getData(CacheKey.appVersionDetails) != nil)
        {
            let appVersionDetails = try! JSONDecoder().decode(KKAppVersionResults.self, from: KeychainSwift().getData(CacheKey.appVersionDetails)!)
            
            return appVersionDetails
        }
        
        return nil
    }
    
    ///decode user profile
    class func decodeUserProfileFromCache() -> KKUserProfileDetails? {
        
        if (KeychainSwift().getData(CacheKey.userProfile) != nil)
        {
            let userProfile = try! JSONDecoder().decode(KKUserProfileDetails.self, from: KeychainSwift().getData(CacheKey.userProfile)!)
            
            return userProfile
        }
        
        return nil
    }
    
    ///get selected country
    class func decodeSelectedCountryFromCache() -> KKAppVersionCountries {
        
        if (KeychainSwift().getData(CacheKey.selectedCountry) != nil)
        {
            let countryDetails = try! JSONDecoder().decode(KKAppVersionCountries.self, from: KeychainSwift().getData(CacheKey.selectedCountry)!)
            
            return countryDetails
        }
        
        if KKSingleton.sharedInstance.countryArray.count > 0 {
            
            return KKSingleton.sharedInstance.countryArray.first(where: {$0.currency == CurrencyCode.Malaysia})!
        }
        else
        {
            let jsonString = """
            {
                "code": "\(CountryCode.Malaysia)",
                "name": "Malaysia",
                "locale": "https://legend.fteg.dev/storage/upload/images/countries/malaysia.png",
                "country_calling_code": "60",
                "currency": "\(CurrencyCode.Malaysia)",
                "currency_name": "Malaysia Ringgit"
            }
            """
            
            return try! JSONDecoder().decode(KKAppVersionCountries.self, from: jsonString.data(using: .utf8)!)
        }
    }
    
    ///get selected language
    class func decodeSelectedLanguageFromCache() -> KKAppVersionLanguages {
            
        if (KeychainSwift().getData(CacheKey.selectedLanguage) != nil)
        {
            let appLanguage = try! JSONDecoder().decode(KKAppVersionLanguages.self, from: KeychainSwift().getData(CacheKey.selectedLanguage)!)
            
            return appLanguage
        }
        
        if KKSingleton.sharedInstance.languageArray.count > 0 {
            
            return KKSingleton.sharedInstance.languageArray.first(where: {$0.locale == LocaleCode.English})!
        }
        else
        {
            let jsonString = """
            {
                "locale": "\(LocaleCode.English)",
                "name": "\(LocaleName.English)"
            }
            """
            
            return try! JSONDecoder().decode(KKAppVersionLanguages.self, from: jsonString.data(using: .utf8)!)
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
    
    class func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
