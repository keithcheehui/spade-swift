//
//  KKInboxMessageResults.swift
//
//  Created by Wong Sai Khong on 29/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKInboxMessageResults: Codable {

  enum CodingKeys: String, CodingKey {
    case inboxMessages = "inbox_messages"
  }

  var inboxMessages: [KKInboxMessageDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    inboxMessages = try container.decodeIfPresent([KKInboxMessageDetails].self, forKey: .inboxMessages)
  }

}

