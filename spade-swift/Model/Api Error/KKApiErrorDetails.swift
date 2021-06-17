//
//  KKApiErrorDetails.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation

struct KKApiErrorDetails: Codable {
    
    var code:           Int?
    var error:          Bool = true
    var message:        String?
    
    enum CodingKeys: String, CodingKey {
        
        case code
        case error
        case message
    }
}
