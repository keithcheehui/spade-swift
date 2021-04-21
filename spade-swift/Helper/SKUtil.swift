//
//  SKUtil.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit
import SystemConfiguration

class SKUtil: NSObject {
    
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
}