//
//  KKBonusResults.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKPromotionResults: Codable {

  enum CodingKeys: String, CodingKey {
    case promotions
  }

  var promotions: [KKPromotionDetails]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    promotions = try container.decodeIfPresent([KKPromotionDetails].self, forKey: .promotions)
  }
}
