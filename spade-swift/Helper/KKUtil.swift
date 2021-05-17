//
//  KKUtil.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
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
    
    ///Add param for GET url
    class func addQueryParams(url: URL, newParams: [URLQueryItem]) -> URL? {

        let urlComponents = NSURLComponents.init(url: url, resolvingAgainstBaseURL: false)
        guard urlComponents != nil else { return nil }
        if (urlComponents?.queryItems == nil) {
            urlComponents!.queryItems = []
        }
        urlComponents!.queryItems!.append(contentsOf: newParams)
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
        UserDefaults.standard.synchronize()
        
        KKUtil.proceedToPage(vc: KKSplashScreenViewController.init())
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
}
