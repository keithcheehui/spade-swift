//
//  KKApiErrorDetails.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation

struct KKApiErrorDetails: Codable {
    
    var status:         String?
    var code:           Int?
    var errorDesc:      String?
    var message:        String?
    
    enum CodingKeys: String, CodingKey {
        
        case status
        case code
        case errorDesc          = "error_description"
        case message
    }
}
