//
//  KKGeneralResponse.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKGeneralResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case code
    case status
  }

  var code: Int?
  var status: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    status = try container.decodeIfPresent(String.self, forKey: .status)
  }

}
