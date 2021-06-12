//
//  KKBonusResults.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKBonusResults: Codable {

  enum CodingKeys: String, CodingKey {
    case bonuses
  }

  var bonuses: [KKBonusDetails]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    bonuses = try container.decodeIfPresent([KKBonusDetails].self, forKey: .bonuses)
  }
}
