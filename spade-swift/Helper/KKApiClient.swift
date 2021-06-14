//
//  KKApiClient.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import UIKit
import Alamofire

class KKApiClient: NSObject {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:ApiRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in

            if (!KKUtil.isConnectedToInternet()) {
                completion(.failure("connection offline"))
                return
            }

            AF.request(route).validate()
                .responseDecodable(decoder: decoder, completionHandler: { (response: (AFDataResponse<T>)) in

                switch response.result {
                case .success(let value):
                    print("success = \(value)")
                    completion(.success(value))
                case .failure(let error):

                    guard let data = response.data else { return completion(.failure(error.localizedDescription)) }
                    
                    do {
                        
                        let apiErrorDetail = try decoder.decode(KKApiErrorDetails.self, from: data)
                        print("failure data = \(apiErrorDetail)")

                        guard let apiError = apiErrorDetail.status
                            else {
                            
                            guard let apiMessage = apiErrorDetail.message
                                else {
                                    return completion(.failure(error.localizedDescription))
                                }
                                
                            return completion(.failure(apiMessage))
                        }
                        completion(.failure(apiError))
                    }
                    catch
                    {
                        completion(.failure("Unexpected error. Please try again."))
                    }
                }
            })
        })
    }
    
    //MARK:- Version Control
    
    static func getAppVersion() -> Future<KKAppVersionResponse> {
        
        let parameter = [APIKeys.platform       : Platform.iOS,
                        ] as [String : Any]
        
        return performRequest(route: .appVersion(parameter: parameter))
    }

    //MARK:- OTP
    
    static func sendOTPRequest(phoneNumber: String) -> Future<KKOTPRequestResponse> {
        
        let parameter = [APIKeys.phoneNumber    : phoneNumber,
                        ] as [String : Any]
     
        return performRequest(route: .otpRequest(parameter: parameter))
    }
    
    static func proceedOTPVerification(phoneNumber: String, otpCode: String) -> Future<KKGeneralResponse> {
        
        let parameter = [APIKeys.phoneNumber    : phoneNumber,
                         APIKeys.OTPCode        : otpCode
                        ] as [String : Any]
     
        return performRequest(route: .otpVerify(parameter: parameter))
    }
    
    //MARK:- User Authentication Flow
    
    static func userAccountLogin(username: String, password: String) -> Future<KKUserCredential> {
        
        let parameter = [APIKeys.username       : username,
                         APIKeys.password       : password,
                         APIKeys.type           : LoginType.username,
                        ] as [String : Any]
        
        return performRequest(route: .userAccountLogin(parameter: parameter))
    }
    
    static func userAccountRegistration(username: String, password: String, phoneNumber: String) -> Future<KKUserCredential> {
        
        let parameter = [APIKeys.username               : username,
                         APIKeys.password               : password,
                         APIKeys.confirmPassword        : password,
                         APIKeys.phoneNumber            : phoneNumber,
                         APIKeys.registrationPlatform   : Platform.iOS,
                         APIKeys.type                   : RegistrationType.phoneNumber,
                         APIKeys.countryCode            : "MYS"
                        ] as [String : Any]
        
        return performRequest(route: .userAccountRegistration(parameter: parameter))
    }
    
    //MARK:- Content
    
    static func getContentAnnouncement() ->  Future<KKAnnouncementResponse> {
        
        let parameter = [APIKeys.locale    : LocaleCode.English,
                        ] as [String : Any]
        
        return performRequest(route: .getAnnouncementContent(parameter: parameter))
    }
    
    static func getContentGroupsAndPlatform() -> Future<KKGroupPlatformResponse> {
        
        let parameter = [APIKeys.locale         : LocaleCode.English,
                         APIKeys.countryCode    : CountryCode.Malaysia
                        ] as [String : Any]
        
        return performRequest(route: .getGroupAndPlatformContent(parameter: parameter))
    }
    
    static func getAllPlatformProduct() -> Future<KKPlatformProductResponse> {
        
        let parameter = [APIKeys.locale    : LocaleCode.English,
                        ] as [String : Any]
        
        return performRequest(route: .getPlatformProductsContent(parameter: parameter))
    }
    
    static func getSystemMessages() -> Future<KKSystemMessageResponse> {
        
        let parameter = [APIKeys.locale    : LocaleCode.English,
                        ] as [String : Any]
        
        return performRequest(route: .getSystemMessageContent(parameter: parameter))
    }
    
    //MARK:- FAQ
    
    static func getCustomerFAQ() -> Future<KKFAQResponse> {
        
        let parameter = [APIKeys.locale    : LocaleCode.English,
                        ] as [String : Any]
        
        return performRequest(route: .customerFAQ(parameter: parameter))
    }
    
    //MARK:- Live Chat
    
    static func getCustomerLiveChat() -> Future<KKLiveChatResponse> {
        
        let parameter = [APIKeys.locale    : LocaleCode.English,
                        ] as [String : Any]
        
        return performRequest(route: .customerLiveChat(parameter: parameter))
    }
    
    //MARK:- Bonus
    
    static func getBonusList() -> Future<KKBonusResponse> {
        
        let parameter = [APIKeys.locale    : LocaleCode.English,
                        ] as [String : Any]
        
        return performRequest(route: .getBonusList(parameter: parameter))
    }

    //MARK:- Affiliate Guideline
    
    static func getGuidelineList() -> Future<KKGuidelineResponse> {
        
        let parameter = [APIKeys.locale    : LocaleCode.English,
                        ] as [String : Any]
        
        return performRequest(route: .getGuidelineList(parameter: parameter))
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
