//
//  KKFAQResults.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKFAQResults: Codable {

  enum CodingKeys: String, CodingKey {
    case faqCode = "faq_code"
    case faq
  }

  var faqCode: KKFAQFaqCode?
  var faq: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    faqCode = try container.decodeIfPresent(KKFAQFaqCode.self, forKey: .faqCode)
    faq = try container.decodeIfPresent(String.self, forKey: .faq)
  }

}
