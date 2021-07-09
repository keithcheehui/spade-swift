//
//  KKResults.swift
//
//  Created by Wong Sai Khong on 02/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKHistoryResults: Codable {

  enum CodingKeys: String, CodingKey {
    case history
  }

  var history: [KKHistoryDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    history = try container.decodeIfPresent([KKHistoryDetails].self, forKey: .history)
  }

}
