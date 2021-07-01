//
//  KKTokenManager.swift
//  spade-swift
//
//  Created by Keith CheeHui on 06/06/2021.
//

import UIKit
import KeychainSwift

class KKTokenManager: NSObject {
    
    struct TokenManagerConstant {
        static let expireTimeBuffer: Double = 60*5
    }
    
    class func accessToken() -> String {
        return UserDefaults.standard.string(forKey: CacheKey.accessToken) ?? ""
    }
    
    class func refreshToken() -> String {
        return UserDefaults.standard.string(forKey: CacheKey.refreshToken) ?? ""
    }
    
    class func setUserCredential(userCredential: KKUserCredential) {
        UserDefaults.standard.set(userCredential.results!.accessToken!, forKey: CacheKey.accessToken)
        UserDefaults.standard.synchronize()
    }
}
