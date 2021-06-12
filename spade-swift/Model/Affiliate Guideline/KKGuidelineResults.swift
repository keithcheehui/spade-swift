//
//  KKGuidelineResults.swift
//  spade-swift
//
//  Created by Wong Sai Khong on 12/06/2021.
//

import Foundation

struct KKGuidelineResults: Codable {

  enum CodingKeys: String, CodingKey {
    case affiliate_guidelines
  }

  var affiliate_guidelines: [KKGuidelineDetails]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    affiliate_guidelines = try container.decodeIfPresent([KKGuidelineDetails].self, forKey: .affiliate_guidelines)
  }
}
