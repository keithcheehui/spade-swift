//
//  KKSingleton.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit

class KKSingleton: NSObject {
    
    static let sharedInstance = KKSingleton.init()
    
    var countryArray:       [KKAppVersionCountries] = []
    var languageArray:      [KKAppVersionLanguages] = []
    
        
    private override init() {}

}
