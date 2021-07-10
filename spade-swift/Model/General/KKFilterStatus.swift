//
//  KKFilterStatus.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKFilterStatus: Codable {

  enum CodingKeys: String, CodingKey {
    case fail = "FAIL"
    case pending = "PENDING"
    case success = "SUCCESS"
  }

  var fail: String?
  var pending: String?
  var success: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    fail = try container.decodeIfPresent(String.self, forKey: .fail)
    pending = try container.decodeIfPresent(String.self, forKey: .pending)
    success = try container.decodeIfPresent(String.self, forKey: .success)
  }

}
