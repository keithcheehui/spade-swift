//
//  KKApiRouter.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case appVersion(parameter: [String: Any])
    case otpRequest(parameter: [String: Any])
    case otpVerify(parameter: [String: Any])
    case userAccountLogin(parameter: [String: Any])
    case userAccountRegistration(parameter: [String: Any])
    case userForgotPassword(parameter: [String: Any])
    case getAnnouncementContent(parameter: [String: Any])
    case getGroupAndPlatformContent(parameter: [String: Any])
    case getPlatformProductsContent(parameter: [String: Any])
    case getSystemMessageContent(parameter: [String: Any])
    case customerFAQ(parameter: [String: Any])
    case customerLiveChat(parameter: [String: Any])
    case getBonusList(parameter: [String: Any])
    case getGuidelineList(parameter: [String: Any])
    
    
    case getUserProfile
    case getLatestWallet
    case logOutUser


    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        
        switch self {
        
        case .appVersion,
             .getUserProfile,
             .getLatestWallet,
             .customerFAQ,
             .customerLiveChat,
             .getAnnouncementContent,
             .getGroupAndPlatformContent,
             .getPlatformProductsContent,
             .getSystemMessageContent,
             .getBonusList,
             .getGuidelineList:
            return .get
        
        case .otpRequest,
             .otpVerify,
             .userAccountLogin,
             .userAccountRegistration,
             .userForgotPassword,
             .logOutUser:
            return .post
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        
        switch self {
        
        case .appVersion:
            return "version"
        
        case .otpRequest:
            return "otp/request"
        
        case .otpVerify:
            return "otp/verify"
            
        case .userAccountLogin:
            return "login"
            
        case .userAccountRegistration:
            return "register"
            
        case .userForgotPassword:
            return "password/forgot"
            
        case .getUserProfile:
            return "member/profile"
            
        case .getLatestWallet:
            return "member/getLatestWalletBalance"
            
        case .customerFAQ:
            return "customer_service/faqs"
            
        case .customerLiveChat:
            return "customer_service/live_chats"
            
        case .getAnnouncementContent:
            return "content/announcements"
            
        case .getGroupAndPlatformContent:
            return "content/groups"
            
        case .getPlatformProductsContent:
            return "content/products"
            
        case .getSystemMessageContent:
            return "content/system_messages"
            
        case .getBonusList:
            return "content/bonus"
            
        case .getGuidelineList:
            return "content/affiliate_guidelines"
            
        case .logOutUser:
            return "logout"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
           
        switch self {
        
        case .appVersion(let parameter):
            return parameter
            
        case .otpRequest(let parameter):
            return parameter
            
        case .otpVerify(let parameter):
            return parameter
            
        case .userAccountLogin(let parameter):
            return parameter
            
        case .userAccountRegistration(let parameter):
            return parameter
            
        case .userForgotPassword(let parameter):
            return parameter
            
        case .customerFAQ(let parameter):
            return parameter
            
        case .customerLiveChat(let parameter):
            return parameter
            
        case .getAnnouncementContent(let parameter):
            return parameter
            
        case .getGroupAndPlatformContent(let parameter):
            return parameter
            
        case .getPlatformProductsContent(let parameter):
            return parameter
            
        case .getSystemMessageContent(let parameter):
            return parameter
            
        case .getBonusList(let parameter):
            return parameter

        case .getGuidelineList(let parameter):
            return parameter
            
        case .getUserProfile,
             .getLatestWallet,
             .logOutUser:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url : URL = try Spade.DevServer.baseApiURL.asURL()
        
        var urlRequest : URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        if (method.rawValue == "GET" && parameters != nil)
        {
            let dict: NSDictionary = parameters! as NSDictionary

            for i in 0 ..< dict.allKeys.count {

                urlRequest = URLRequest(url: KKUtil.addQueryParams(url: urlRequest.url!, newParams: [URLQueryItem.init(name: dict.allKeys[i] as! String, value: (dict.object(forKey: dict.allKeys[i]) as! String))])!)
            }
        }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if (UserDefaults.standard.bool(forKey: CacheKey.loginStatus))
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
