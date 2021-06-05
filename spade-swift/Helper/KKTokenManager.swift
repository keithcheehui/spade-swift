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
        
        let token = KeychainSwift().get(CacheKey.accessToken)
        return token!
    }
    
    class func refreshToken() -> String {
        
        let token = KeychainSwift().get(CacheKey.refreshToken)
        
        if token == nil {
            
            return ""
        }
        
        return token!
    }
    
    class func setUserCredential(userCredential: KKUserCredential) {
        
        KeychainSwift().set(userCredential.data!.accessToken!, forKey: CacheKey.accessToken)
    }
}
