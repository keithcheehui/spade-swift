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

                        guard let apiMessage = apiErrorDetail.message
                        
                        else {
                            return completion(.failure(error.localizedDescription))
                        }
                        return completion(.failure(apiMessage))
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
                         APIKeys.locale         : KKUtil.decodeSelectedLanguageFromCache().locale!
                        ] as [String : Any]
        
        return performRequest(route: .appVersion(parameter: parameter))
    }
    
    //MARK:- Landing
    
    static func getGuestLandingDetails() -> Future<KKLandingDetailsResponse> {
        
        let parameter = [APIKeys.locale         : KKUtil.decodeSelectedLanguageFromCache().locale!,
                         APIKeys.countryCode    : KKUtil.decodeSelectedCountryFromCache().code!
                        ] as [String : Any]
        
        return performRequest(route: .guestLandingDetails(parameter: parameter))
    }
    
    static func getMemberLandingDetails() -> Future<KKLandingDetailsResponse> {
        
        let parameter = [APIKeys.locale         : KKUtil.decodeSelectedLanguageFromCache().locale!,
                         APIKeys.countryCode    : KKUtil.decodeSelectedCountryFromCache().code!
                        ] as [String : Any]
        
        return performRequest(route: .memberLandingDetails(parameter: parameter))
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
    
    static func sendForgotPasswordOTPRequest(phoneNumber: String) -> Future<KKOTPRequestResponse> {
        
        let parameter = [APIKeys.phoneNumber    : phoneNumber,
                        ] as [String : Any]
     
        return performRequest(route: .forgotPasswordOTPRequest(parameter: parameter))
    }
    
    static func proceedForgotPasswordOTPVerification(phoneNumber: String, otpCode: String) -> Future<KKGeneralResponse> {
        
        let parameter = [APIKeys.phoneNumber    : phoneNumber,
                         APIKeys.OTPCode        : otpCode
                        ] as [String : Any]
     
        return performRequest(route: .forgotPasswordOTPVerify(parameter: parameter))
    }
    
    //MARK:- OAuth Flow
    
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
                         APIKeys.countryCode            : KKUtil.decodeSelectedCountryFromCache().code!
                        ] as [String : Any]
        
        return performRequest(route: .userAccountRegistration(parameter: parameter))
    }
    
    static func userForgotPassword(password: String, phoneNumber: String) -> Future<KKGeneralResponse> {
        
        let parameter = [APIKeys.newPassword            : password,
                         APIKeys.confirmNewPassword     : password,
                         APIKeys.phoneNumber            : phoneNumber,
                         APIKeys.registrationPlatform   : Platform.iOS,
                         APIKeys.type                   : RegistrationType.phoneNumber,
                         APIKeys.countryCode            : KKUtil.decodeSelectedCountryFromCache().code!
                        ] as [String : Any]
        
        return performRequest(route: .userForgotPassword(parameter: parameter))
    }
    
    static func logOutUser() -> Future<KKGeneralResponse> {
        
        return performRequest(route: .logOutUser)
    }
    
    //MARK:- User Profile
    
    static func getUserProfile() -> Future<KKUserProfileResponse> {
        
        return performRequest(route: .getUserProfile)
    }
    
    static func updateUserProfile(email: String = KKUtil.decodeUserProfileFromCache()?.email ?? "",
                                  gender: String = KKUtil.decodeUserProfileFromCache()?.gender ?? GenderType.male,
                                  birthday: String = KKUtil.decodeUserProfileFromCache()?.dob ?? "") -> Future<KKGeneralResponse> {
        
        let parameter = [APIKeys.email      : email,
                         APIKeys.gender     : gender,
                         APIKeys.birthday   : birthday
                        ] as [String : Any]
        
        return performRequest(route: .updateUserProfile(parameter: parameter))
    }
    
    static func updateUserLanguagePreference(languageCode: String) -> Future<KKGeneralResponse> {
     
        let parameter = [APIKeys.locale     : languageCode
                        ] as [String : Any]
        
        return performRequest(route: .updateUserLanguagePreference(parameter: parameter))
    }
    
    static func changePassword(currentPwd: String, newPwd: String) -> Future<KKGeneralResponse> {
     
        let parameter = [APIKeys.currentPassword : currentPwd,
                         APIKeys.newPassword : newPwd,
                         APIKeys.confirmNewPassword : newPwd
                        ] as [String : Any]
        
        return performRequest(route: .changePassword(parameter: parameter))
    }
    
    //MARK:- User Details
    
    static func getUserLatestWallet() -> Future<KKUserWalletResponse> {
        
        return performRequest(route: .getLatestWallet)
    }
    
    static func getUserBettingGroupAndPlatform() -> Future<KKUserBettingResponse> {
        
        let parameter = [APIKeys.locale    : KKUtil.decodeSelectedLanguageFromCache().locale!,
                        ] as [String : Any]
        
        return performRequest(route: .getUserBettingGroupAndPlatform(parameter: parameter))
    }
    
    static func getUserBettingCashFlow() -> Future<KKUserCashFlowResponse> {
        
        let parameter = [APIKeys.filterDuration    : APIValue.last90Days
                        ] as [String : Any]
        
        return performRequest(route: .getUserBettingCashflow(parameter: parameter))
    }
    
    static func getUserBettingRecord() -> Future<KKUserBettingHistoryResponse> {
        
        let parameter = [APIKeys.filterDuration : APIValue.last90Days
                        ] as [String : Any]
        
        return performRequest(route: .getUserBettingRecord(parameter: parameter))
    }

    //MARK:- Content
    
    static func getContentAnnouncement() ->  Future<KKAnnouncementResponse> {
        
        let parameter = [APIKeys.locale    : KKUtil.decodeSelectedLanguageFromCache().locale!,
                        ] as [String : Any]
        
        return performRequest(route: .getAnnouncementContent(parameter: parameter))
    }
    
    static func getContentGroupsAndPlatform() -> Future<KKGroupPlatformResponse> {
        
        let parameter = [APIKeys.locale         : KKUtil.decodeSelectedLanguageFromCache().locale!,
                         APIKeys.countryCode    : KKUtil.decodeSelectedCountryFromCache().code!
                        ] as [String : Any]
        
        return performRequest(route: .getGroupAndPlatformContent(parameter: parameter))
    }
    
    static func getAllPlatformProduct(gCode: String = "", gameTypeCode: String = "") -> Future<KKPlatformProductResponse> {
        
        let parameter = [APIKeys.locale         : KKUtil.decodeSelectedLanguageFromCache().locale!,
                         APIKeys.gameTypeCode   : gameTypeCode,
                         APIKeys.groupCode      : gCode,
                         APIKeys.countryCode    : KKUtil.decodeSelectedCountryFromCache().code!
                        ] as [String : Any]
        
        return performRequest(route: .getPlatformProductsContent(parameter: parameter))
    }
    
    static func getSystemMessages() -> Future<KKSystemMessageResponse> {
        
        let parameter = [APIKeys.locale    : KKUtil.decodeSelectedLanguageFromCache().locale!,
                        ] as [String : Any]
        
        return performRequest(route: .getSystemMessageContent(parameter: parameter))
    }
    
    static func getPromotionContent() -> Future<KKPromotionResponse> {
        
        let parameter = [APIKeys.locale    : KKUtil.decodeSelectedLanguageFromCache().locale!,
                        ] as [String : Any]
        
        return performRequest(route: .getPromotionContent(parameter: parameter))
    }
    
    static func getAffiliateGuidelineContent() -> Future<KKGuidelineResponse> {
        
        let parameter = [APIKeys.locale    : KKUtil.decodeSelectedLanguageFromCache().locale!,
                        ] as [String : Any]
        
        return performRequest(route: .getAffiliateGuidelineContent(parameter: parameter))
    }
    
    //MARK:- Customer Service
    
    static func getCustomerFAQ() -> Future<KKFAQResponse> {
        
        let parameter = [APIKeys.locale    : KKUtil.decodeSelectedLanguageFromCache().locale!,
                        ] as [String : Any]
        
        return performRequest(route: .customerFAQ(parameter: parameter))
    }
        
    static func getCustomerLiveChat() -> Future<KKLiveChatResponse> {
        
        let parameter = [APIKeys.locale    : KKUtil.decodeSelectedLanguageFromCache().locale!,
                        ] as [String : Any]
        
        return performRequest(route: .customerLiveChat(parameter: parameter))
    }
    
    //MARK:- Member Deposit
    
    static func getMemberDepositBankAccount() -> Future<KKDepositBankResponse> {
        
        return performRequest(route: .memberDepositBankAccount)
    }
    
    static func updateMemberDeposit(parameter: [String : Any]) -> Future<KKGeneralResponse> {
        
        return performRequest(route: .memberDeposit(parameter: parameter))
    }
    
    static func getMemberDepositHistory(historyStatus: String? = nil) -> Future<KKDepositHistoryResponse> {
        
        let parameter = [String : Any]()
        
        return performRequest(route: .memberDepositHistory(parameter: parameter))
    }
    
    //MARK:- Member Withdraw
    
    static func getMemberWithdrawBankAccount() -> Future<KKWithdrawBankResponse> {
        
        return performRequest(route: .memberWithdrawBankAccount)
    }
    
    static func addMemberWithdrawBankAccount(parameter: [String : Any]) -> Future<KKAddWithdrawBankResponse> {
        
        return performRequest(route: .addMemberWithdrawBankAccount(parameter: parameter))
    }
    
    static func updateMemberWithdrawal(amount: Float, bankAcc: String) -> Future<KKGeneralResponse> {
        
        let parameter = [APIKeys.withdrawAmount     : amount,
                         APIKeys.withdrawAccountNo  : bankAcc
                        ] as [String : Any]
        
        return performRequest(route: .memberWithdrawal(parameter: parameter))
    }
    
    static func getMemberWithdrawHistory(historyStatus: String? = nil) -> Future<KKWithdrawHistoryResponse> {
        
        let parameter = [String : Any]()
        
        return performRequest(route: .memberWithdrawHistory(parameter: parameter))
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
