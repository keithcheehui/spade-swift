//
//  KKSingleton.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit

class KKSingleton: NSObject {
    
    static let sharedInstance = KKSingleton.init()
    
        
    private override init() {}

}
