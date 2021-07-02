//
//  KKInboxUnreadResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKInboxUnreadResults: Codable {

  enum CodingKeys: String, CodingKey {
    case inboxUnreadMessages = "inbox_unread_messages"
  }

  var inboxUnreadMessages: Bool?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    inboxUnreadMessages = try container.decodeIfPresent(Bool.self, forKey: .inboxUnreadMessages) ?? false
  }

}
