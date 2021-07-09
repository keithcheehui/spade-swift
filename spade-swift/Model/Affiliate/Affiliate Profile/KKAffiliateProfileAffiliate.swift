//
//  KKAffiliateProfileAffiliate.swift
//
//  Created by Wong Sai Khong on 10/07/2021
//  Copyright (c) . All rights reserved.
//

import Foundation

struct KKAffiliateProfileAffiliate: Codable {

  enum CodingKeys: String, CodingKey {
    case referrerCode = "referrer_code"
    case commission
    case memberRecruited = "member_recruited"
    case affiliateUrl = "affiliate_url"
  }

  var referrerCode: String?
  var commission: KKAffiliateProfileCommission?
  var memberRecruited: Int?
  var affiliateUrl: String?


  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    referrerCode = try container.decodeIfPresent(String.self, forKey: .referrerCode)
    commission = try container.decodeIfPresent(KKAffiliateProfileCommission.self, forKey: .commission)
    memberRecruited = try container.decodeIfPresent(Int.self, forKey: .memberRecruited)
    affiliateUrl = try container.decodeIfPresent(String.self, forKey: .affiliateUrl)
  }

}
