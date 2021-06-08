//
//  KKSystemMessageResults.swift
//
//  Created by Keith CheeHui on 09/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKSystemMessageResults: Codable {

  enum CodingKeys: String, CodingKey {
    case systemMessages = "system_messages"
  }

  var systemMessages: [KKSystemMessageDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    systemMessages = try container.decodeIfPresent([KKSystemMessageDetails].self, forKey: .systemMessages)
  }

}
