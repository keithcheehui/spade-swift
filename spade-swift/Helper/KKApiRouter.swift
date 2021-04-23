//
//  KKApiRouter.swift
//  spade-swift
//
//  Created by Keith CheeHui on 23/04/2021.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case userAccountLogin(parameter: [String: Any])
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        
        switch self {
        
        case .userAccountLogin:
            return .post
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        
        switch self {
            
        case .userAccountLogin:
            return ""
            
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
           
        switch self {
            
        case .userAccountLogin(let parameter):
            return parameter
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url : URL = try Spade.DevServer.baseApiURL.asURL()
        
        var urlRequest : URLRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

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
