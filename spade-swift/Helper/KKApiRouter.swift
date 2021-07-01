//
//  KKApiRouter.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    //MARK: - Auth
    case registerOTPRequest(parameter: [String: Any])
    case registerOTPVerify(parameter: [String: Any])
    case registration(parameter: [String: Any])
    case login(parameter: [String: Any])
    case forgotPasswordOTPRequest(parameter: [String: Any])
    case forgotPasswordOTPVerify(parameter: [String: Any])
    case forgotPassword(parameter: [String: Any])

    //MARK: - Public
    case appVersion(parameter: [String: Any])
    case guestLandingData(parameter: [String: Any])
    case getGroupAndPlatform(parameter: [String: Any])
    case getGameTypeListing(parameter: [String: Any])
    case getAnnouncement(parameter: [String: Any])
    case getFAQ(parameter: [String: Any])
    case getLiveChat(parameter: [String: Any])
    case getPromotion(parameter: [String: Any])
    case getAffiliateGuideline(parameter: [String: Any])
    
    //MARK: - Private
    //MARK: - Deposit / Withdrawal
    case addUserBankCard(parameter: [String: Any])
    case deleteUserBankCard(parameter: [String: Any])
    case depositPageData
    case deposit(parameter: [String: Any])
    case depositHistory(parameter: [String: Any])
    case withdrawPageData
    case withdraw(parameter: [String: Any])
    case withdrawHistory(parameter: [String: Any])

    //MARK: - Personal Center
    case getUserProfile
    case updateUserProfile(parameter: [String: Any])
    case getUserBettingPlatformsAndGroups(parameter: [String: Any])
    case getUserAccountDetails(parameter: [String: Any])
    case getUserBettingRecord(parameter: [String: Any])
    
    //MARK: - Inbox
    case getInbox(parameter: [String: Any])
    case getInboxReadStatus
    case updateInboxReadStatus(parameter: [String: Any])
    
    case memberLandingData(parameter: [String: Any])
    case getLatestWallet
    case updateUserLanguagePreference(parameter: [String: Any])
    case changePassword(parameter: [String: Any])
    case logOutUser
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        
        switch self {
        
        case .appVersion,
             .guestLandingData,
             .getGroupAndPlatform,
             .getGameTypeListing,
             .getAnnouncement,
             .getFAQ,
             .getLiveChat,
             .getPromotion,
             .getAffiliateGuideline,
             .depositPageData,
             .depositHistory,
             .withdrawPageData,
             .withdrawHistory,
             .getUserProfile,
             .getUserBettingPlatformsAndGroups,
             .getUserAccountDetails,
             .getUserBettingRecord,
             .getInbox,
             .getInboxReadStatus,
             .memberLandingData,
             .getLatestWallet:
            return .get
        
        case .registerOTPRequest,
             .registerOTPVerify,
             .registration,
             .login,
             .forgotPasswordOTPRequest,
             .forgotPasswordOTPVerify,
             .forgotPassword,
             .addUserBankCard,
             .deposit,
             .withdraw,
             .updateInboxReadStatus,
             .changePassword,
             .logOutUser:
            return .post
            
        case .updateUserProfile,
             .updateUserLanguagePreference:
            return .put
            
        case .deleteUserBankCard:
            return .delete
        }
    }
    
    // MARK: - Path
    private var path: String {
        
        switch self {
        
        case .registerOTPRequest:
            return "otp/request"
            
        case .registerOTPVerify:
            return "otp/verify"
            
        case .registration:
            return "register"
            
        case .login:
            return "login"

        case .forgotPasswordOTPRequest:
            return "otp/forgot/request"
            
        case .forgotPasswordOTPVerify:
            return "otp/forgot/verify"
            
        case .forgotPassword:
            return "password/forgot"
            
        case .appVersion:
            return "version"
        
        case .guestLandingData:
            return "content/guestLanding"
            
        case .getGroupAndPlatform:
            return "content/groups"
            
        case .getGameTypeListing:
            return "content/gameTypeListing"
            
        case .getAnnouncement:
            return "content/announcements"
            
        case .getFAQ:
            return "customerService/faqs"
            
        case .getLiveChat:
            return "customerService/liveChats"
            
        case .getPromotion:
            return "content/promotions"
            
        case .getAffiliateGuideline:
            return "content/affiliate_guidelines"
            
        case .addUserBankCard:
            return "member/finance/addUserBankCard"
            
        case .deleteUserBankCard:
            return "member/finance/removeUserBankCard"
            
        case .depositPageData:
            return "member/deposit/depositPageData"
            
        case .deposit:
            return "member/deposit/deposit"
        
        case .depositHistory:
            return "member/deposit/depositHistory"
            
        case .withdrawPageData:
            return "member/withdraw/withdrawPageData"
            
        case .withdraw:
            return "member/withdraw/withdrawal"
                
        case .withdrawHistory:
            return "member/withdraw/withdrawHistory"
            
        case .getUserProfile:
            return "member/profile"
            
        case .updateUserProfile:
            return "member/updateUserProfile"
            
        case .getUserBettingPlatformsAndGroups:
            return "member/betslipsPlatformsAndGroups"
            
        case .getUserAccountDetails:
            return "member/cashflows"
            
        case .getUserBettingRecord:
            return "member/betslips"
            
        case .getInbox:
            return "member/inbox"
            
        case .getInboxReadStatus:
            return "member/inboxUnreadMsgsBoolean"
            
        case .updateInboxReadStatus:
            return "member/updateInboxReadStatus"
            
        case .memberLandingData:
            return "member/memberLanding"
            
        case .getLatestWallet:
            return "member/latestWalletBalance"
        
        case .updateUserLanguagePreference:
            return "member/updateUserLanguagePreference"
            
        case .changePassword:
            return "member/password/change"
            
        case .logOutUser:
            return "logout"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
           
        switch self {
        case .registerOTPRequest(let parameter):
            return parameter
        
        case .registerOTPVerify(let parameter):
            return parameter
            
        case .registration(let parameter):
            return parameter
            
        case .login(let parameter):
            return parameter
            
        case .forgotPasswordOTPRequest(let parameter):
            return parameter
            
        case .forgotPasswordOTPVerify(let parameter):
            return parameter
            
        case .forgotPassword(let parameter):
            return parameter
            
        case .appVersion(let parameter):
            return parameter
        
        case .guestLandingData(let parameter):
            return parameter
            
        case .getGroupAndPlatform(let parameter):
            return parameter

        case .getGameTypeListing(let parameter):
            return parameter
            
        case .getAnnouncement(let parameter):
            return parameter
            
        case .getFAQ(let parameter):
            return parameter
            
        case .getLiveChat(let parameter):
            return parameter
            
        case .getPromotion(let parameter):
            return parameter
            
        case .getAffiliateGuideline(let parameter):
            return parameter
            
        case .addUserBankCard(let parameter):
            return parameter
            
        case .deleteUserBankCard(let parameter):
            return parameter
            
        case .deposit(let parameter):
            return parameter
            
        case .depositHistory(let parameter):
            return parameter
            
        case .withdraw(let parameter):
            return parameter
            
        case .withdrawHistory(let parameter):
            return parameter
            
        case .updateUserProfile(let parameter):
            return parameter
            
        case .getUserBettingPlatformsAndGroups(let parameter):
            return parameter
            
        case .getUserAccountDetails(let parameter):
            return parameter
            
        case .getUserBettingRecord(let parameter):
            return parameter
            
        case .getInbox(let parameter):
            return parameter
            
        case .updateInboxReadStatus(let parameter):
            return parameter
            
        case .memberLandingData(let parameter):
            return parameter
            
        case .updateUserLanguagePreference(let parameter):
            return parameter
            
        case .changePassword(let parameter):
            return parameter
            
        case .getInboxReadStatus,
             .depositPageData,
             .withdrawPageData,
             .getUserProfile,
             .getLatestWallet,
             .logOutUser:
            return nil
        }
    }
    
    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        
        let url : URL = try Spade.DevServer.baseApiURL.asURL()
        
        var urlRequest : URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        if method.rawValue == "GET" && parameters != nil {
            
            if let dict = parameters as? [String: String] {
            
                if let url = KKUtil.addQueryParams(url: urlRequest.url!, parameters: dict) {
                    
                    urlRequest = URLRequest(url: url)
                    
                } else {
                    
                    urlRequest = URLRequest(url: url.appendingPathComponent(path))
                }
            }
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(HTTPHeaderFieldValue.contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(HTTPHeaderFieldValue.contentType.rawValue, forHTTPHeaderField: HTTPHeaderField.accept.rawValue)

        if UserDefaults.standard.bool(forKey: CacheKey.loginStatus)
        {
            urlRequest.setValue(String(format: "Bearer %@", KKTokenManager.accessToken()), forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        }

        // Parameters
        if let parameters = parameters
        {
            do
            {
                if (urlRequest.httpMethod == "POST" || urlRequest.httpMethod == "DELETE" || urlRequest.httpMethod == "PUT")
                {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            }
            catch
            {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }

    
}
