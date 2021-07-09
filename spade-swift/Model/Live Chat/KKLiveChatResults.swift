//
//  KKLiveChatResults.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKLiveChatResults: Codable {

  enum CodingKeys: String, CodingKey {
    case liveChats = "live_chats"
  }

  var liveChats: [KKLiveChatDetails]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    liveChats = try container.decodeIfPresent([KKLiveChatDetails].self, forKey: .liveChats)
  }
}
