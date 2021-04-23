//
//  KKApiErrorDetails.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation

struct KKApiErrorDetails: Codable {
    
    var error:          String?
    var errorDesc:      String?
    var message:        String?
    
    enum CodingKeys: String, CodingKey {
        
        case error
        case errorDesc          = "error_description"
        case message
    }
}
