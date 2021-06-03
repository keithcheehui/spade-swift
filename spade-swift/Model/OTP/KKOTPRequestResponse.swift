//
//  KKOTPRequestResponse.swift
//
//  Created by Keith CheeHui on 04/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKOTPRequestResponse: Codable {

  enum CodingKeys: String, CodingKey {
    case data
    case code
    case status
  }

  var data: KKOTPRequestData?
  var code: Int?
  var status: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    data = try container.decodeIfPresent(KKOTPRequestData.self, forKey: .data)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    status = try container.decodeIfPresent(String.self, forKey: .status)
  }

}
