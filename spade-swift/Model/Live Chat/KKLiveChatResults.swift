//
//  KKLiveChatResults.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKLiveChatResults: Codable {

  enum CodingKeys: String, CodingKey {
    case live_chats
  }

  var live_chats: [KKLiveChatDetails]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    live_chats = try container.decodeIfPresent([KKLiveChatDetails].self, forKey: .live_chats)
  }
}
