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
                        guard let apiError = apiErrorDetail.error
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

}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
