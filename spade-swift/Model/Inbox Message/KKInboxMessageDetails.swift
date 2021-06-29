//
//  KKInboxMessages.swift
//
//  Created by Wong Sai Khong on 29/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKInboxMessageDetails: Codable {

  enum CodingKeys: String, CodingKey {
    case status
    case content
    case id
    case title
    case updatedAt = "updated_at"
  }

  var status: String?
  var content: String?
  var id: Int?
  var title: String?
  var updatedAt: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    content = try container.decodeIfPresent(String.self, forKey: .content)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
  }

}
