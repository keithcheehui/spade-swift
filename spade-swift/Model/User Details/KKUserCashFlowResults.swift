//
//  KKUserCashflowResults.swift
//
//  Created by Keith CheeHui on 18/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKUserCashFlowResults: Codable {

  enum CodingKeys: String, CodingKey {
    case cashflows
  }

  var cashflows: [KKUserCashFlowDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    cashflows = try container.decodeIfPresent([KKUserCashFlowDetails].self, forKey: .cashflows)
  }

}
