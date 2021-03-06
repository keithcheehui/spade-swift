//
//  KKSingleton.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit

class KKSingleton: NSObject {
    
    static let sharedInstance = KKSingleton.init()
    
    var announcementArray:  [KKAnnouncementDetails] = []
    var countryArray:       [KKAppVersionCountries] = []
    var languageArray:      [KKAppVersionLanguages] = []
    var groupPlatformArray: [KKGroupPlatformGroups] = []
    var appVersion:         KKAppVersionAppVersion!

        
    private override init() {}

}
