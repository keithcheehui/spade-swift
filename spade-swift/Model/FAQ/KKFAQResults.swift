//
//  KKFAQResults.swift
//
//  Created by Keith CheeHui on 09/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKFAQResults: Codable {

  enum CodingKeys: String, CodingKey {
    case faqs
  }

  var faqs: [KKFAQDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    faqs = try container.decodeIfPresent([KKFAQDetails].self, forKey: .faqs)
  }

}
