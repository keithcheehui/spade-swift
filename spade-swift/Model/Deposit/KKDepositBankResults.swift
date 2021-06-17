//
//  KKDepositBankResults.swift
//
//  Created by Keith CheeHui on 17/06/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKDepositBankResults: Codable {

  enum CodingKeys: String, CodingKey {
    case companyBanks = "company_banks"
    case depositChannels = "deposit_channels"
    case promotions
  }

  var companyBanks: [KKDepositBankCompanyDetails]?
  var depositChannels: [KKDepositBankDepositChannels]?
  var promotions: [KKPromotionDetails]?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    companyBanks = try container.decodeIfPresent([KKDepositBankCompanyDetails].self, forKey: .companyBanks)
    depositChannels = try container.decodeIfPresent([KKDepositBankDepositChannels].self, forKey: .depositChannels)
    promotions = try container.decodeIfPresent([KKPromotionDetails].self, forKey: .promotions)
  }

}
