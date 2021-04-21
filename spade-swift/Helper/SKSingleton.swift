//
//  SKSingleton.swift
//  spade-swift
//
//  Created by Keith CheeHui on 21/04/2021.
//

import UIKit

class SKSingleton: NSObject {
    
    static let sharedInstance = SKSingleton.init()
    
        
    private override init() {}

}
